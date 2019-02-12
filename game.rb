# frozen_string_literal: true

require_relative 'interface.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'

class Game
  ROUND_DECISION_MENU = ['Пропустить', 'Добавить карту', 'Открыть карты'].freeze
  NEW_ROUND_MENU = %w[Выход Продолжить].freeze

  def initialize
    @interface = Interface.new
    player_name = @interface.invite_dialog

    @player = Player.new(player_name)
    @interface.show_player_balance(@player)

    @dealer = Dealer.new
    @interface.show_player_balance(@dealer)

    @bank = Bank.new
  end

  def play_game
    loop do # раздачи
      @interface.notify "#{'-' * 30}\nНачало раздачи\n#{'-' * 30}"

      start_session
      do_rounds
      finish_session

      unless @bank.can_make_bet?(@player)
        @interface.notify 'Вы всё програли'
        break
      end

      unless @bank.can_make_bet?(@dealer)
        @interface.notify 'Вы всё выиграли'
        break
      end

      return unless @interface.menu_dialog(NEW_ROUND_MENU) == 2
    end
  end

  private

  def start_session
    @deck = Deck.new
    @bank.make_bet(@player, @dealer)
    2.times do
      @player.add_card(@deck.extract_card.unmask)
      @dealer.add_card(@deck.extract_card)
    end
  end

  def do_rounds
    loop do # раунд игры
      @interface.show_hand_status([@player, @dealer])

      # Ход игрока
      case @interface.menu_dialog(ROUND_DECISION_MENU)
      when 2 then add_player_card_action
      when 3 then break
      end

      # Ход дилера
      @dealer.add_card(@deck.extract_card) if @dealer.should_get_card?

      break if @player.hand_full? && @dealer.hand_full?
    end
  end

  def add_player_card_action
    if @player.hand_full?
      @interface.notify 'Нельзя брать еще одну карту'
    else
      @player.add_card(@deck.extract_card.unmask)
      @interface.notify "Игрок #{@player} берет карту"
    end
  end

  def finish_session
    @interface.notify "#{'*' * 10} Результат:"
    @dealer.unmask_hand
    @interface.show_hand_status([@player, @dealer])

    case @player.session_result <=> @dealer.session_result
    when 1 then
      @interface.notify "#{'*' * 10} Вы выиграли"
      @bank.reward_winner(@player)
    when 0 then
      @interface.notify "#{'*' * 10} Ровно' "
      @bank.refund(@player, @dealer)
    when -1 then
      @interface.notify "#{'*' * 10} Вы програли"
      @bank.reward_winner(@dealer)
    end
    @player.clean_hand
    @dealer.clean_hand

    @interface.show_player_balance(@player)
    @interface.show_player_balance(@dealer)
    @interface.notify "#{'=' * 30}\nРаздача Завершена\n#{'=' * 30}"
  end
end

Game.new.play_game
