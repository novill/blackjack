# frozen_string_literal: true

require_relative 'card.rb'

class Hand
  MAX_POINTS = 21
  CARDS_LIMIT = 3

  attr_reader :cards

  def initialize
    @cards = []
  end

  def card_sum
    sum = @cards.map(&:value).sum
    return sum if sum <= MAX_POINTS || @cards.none?(&:ace?)

    @cards.select(&ace?).size.times do
      sum -= CARD::ACE_CORRECTION if sum > MAX_POINTS
    end
    sum
  end

  def masked?
    @cards.any?(&:masked)
  end

  def unmask
    @cards.each(&:unmask)
  end

  def full?
    @cards.size == CARDS_LIMIT
  end

  def overload?
    card_sum > MAX_POINTS
  end

  def session_result
    overload? ? 0 : card_sum
  end

  def add_card(card)
    @cards << card
  end

  def clean_cards
    @cards = []
  end

  def to_s
    "#{@cards.join(' ')}. " + ("Сумма: #{card_sum}" unless masked?).to_s
  end
end
