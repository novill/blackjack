# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @cards = []
    @balance = 100
  end

  def card_sum
    # TODO: обработать тузы (их может быть 3)
    @cards.map(&:value).sum
  end

  # def decision
  # end
  #
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
    @balance += 10
  end

  def back_bet
    @balance += 10
  end

  def win_bank(bank)
    @balance += bank
  end

  alias to_s name
end
