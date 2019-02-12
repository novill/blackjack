# frozen_string_literal: true

class Interface
  def notify(message)
    puts message if message
  end

  def invite_dialog
    puts 'Программы для игры покер'
    print 'Введите ваше имя: '
    gets.chomp
  end

  def show_player_balance(player)
    puts "Баланс #{player}: #{player.balance}"
  end

  def show_hand_status(players)
    players.each { |player| puts "Карты #{player}: #{player.hand}" }
  end

  def menu_dialog(menu)
    print_array(menu, 'Выберите действие:')
    gets.to_i
  end

  private

  def print_array(array, start_message = nil)
    puts start_message if start_message
    array.each.with_index(1) { |item, index| puts "#{index}. #{item}" }
    nil
  end
end
