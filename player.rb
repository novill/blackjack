# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @cards = []
    @balance = 100
  end

  def card_sum
    sum = @cards.map(&:value).sum
    return sum if sum <= 21 || @cards.none?(&:ace?)
    # если сумма больше 21 и есть тузы, по очереди тузы считаем за 1
    @cards.select(&ace?).size.times { sum -= 10 if sum > 21 }
    sum
  end

  def session_result
    card_sum <= 21 ? card_sum : 0
  end

  def add_card(card)
    @cards << card
  end

  def clean_cards
    @cards = []
  end

  def show_open_cards
    @cards.map(&:to_s).join(' ')
  end

  def show_masked_cards
    @cards.map { '**' }.join(' ')
  end

  def make_bet
    @balance -= 10
    10
  end

  def back_bet
    @balance += 10
  end

  def win_bank(bank)
    @balance += bank
  end

  alias to_s name
end
