# frozen_string_literal: true

require_relative 'interface.rb'
require_relative 'player.rb'
require_relative 'deck.rb'

class Game
  ROUND_DECISION_MENU = ['Пропустить', 'Добавить карту', 'Открыть карты'].freeze

  def initialize
    @interface = Interface.new
    player_name = @interface.invite_dialog
    @player = Player.new(player_name)
    @dealer = Player.new('Дилер')
  end

  def start_game
    loop do # раздачи
      start_session
      loop do # раунд игры
        # Ход игрока
        case @interface.menu_dialog(ROUND_DECISION_MENU)
        when 1 then add_card_action(@player)
        when 2 then break
        else {} # всё что не 1 и не 2 пропуск хода
        end
        # Ход дилера
        @dealer.add_card(@deck.extract_card) if @dealer.cards.size < 3 && @dealer.card_sum < 17
        break if @player.cards.size == 3 && @dealer.cards.size == 3
      end
      finish_session

      if @player.balance == 0
        @interface.notify 'Вы всё програли'
        break
      end

      if @dealer.balance == 0
        @interface.notify 'Вы всё выиграли'
        break
      end

      return unless @interface.menu_dialog(%w[Выход Продолжить]) == 1
    end
  end

  private

  def add_card_action(player)
    if player.cards.size > 2
      @interface.notify 'Нельзя брать еще одну карту'
    else
      @player.add_card(@deck.extract_card)
    end
  end

  def start_session
    @deck = Deck.new
    @bank = @player.make_bet + @dealer.make_bet

    2.times { @player.add_card(@deck.extract_card) }
    @interface.show_player_card_status(@player)

    2.times { @dealer.add_card(@deck.extract_card) }
    @interface.show_masked_card_status(@dealer)
  end

  def finish_session
    @interface.show_player_card_status(@player)
    @interface.show_player_card_status(@dealer)

    case @player.card_sum <=> @dealer.card_sum # тут добавить ограничения 21
    when 1 then
      @interface.notify 'Вы выиграли'
      @player.win_bank(@bank)
    when 0 then
      @interface.notify 'Ровно'
      @player.back_bet
      @dealer.back_bet
    when -1 then
      @interface.notify 'Вы програли'
      @dealer.win_bank(@bank)
    end
    @player.clean_cards
    @dealer.clean_cards

    @interface.show_player_balance(@player)
    @interface.show_player_balance(@dealer)
    @interface.notify "#{'-' * 30}\nРаздача Завершена\n#{'-' * 30}"
  end
end

Game.new.start_game