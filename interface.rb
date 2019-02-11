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

  def show_player_card_status(player)
    puts "Карты #{player}: #{player.show_open_cards}. Сумма: #{player.card_sum}"
  end

  def show_masked_card_status(player)
    puts "Карты #{player}: #{player.show_masked_cards}"
  end

  def menu_dialog(menu)
    print_array(menu, 'Выберите действие:')
    gets.to_i
  end

  private

  def print_array(array, start_message = nil)
    puts start_message if start_message
    array.each_with_index { |item, index| puts "#{index}. #{item}" }
    nil
  end
end
