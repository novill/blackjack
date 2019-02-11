# frozen_string_literal: true

require_relative 'card.rb'

class Deck
  def initialize
    @all_cards = Card::SUITS.product(Card::FACE_VALUE.keys).map { |suit_face| Card.new(*suit_face) }.shuffle
  end

  def extract_card
    @all_cards.shift
  end
end
