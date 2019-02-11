# frozen_string_literal: true

require_relative 'card.rb'

class Deck
  def initialize
    @cards = (0..51).to_a.shuffle
  end

  def extract_card
    Card.new(@cards.shift)
  end
end
