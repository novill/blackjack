# frozen_string_literal: true

require_relative 'card.rb'

class Deck
  def initialize
    @all_cards = create_deck
  end

  def extract_card
    @all_cards.shift
  end

  private

  def create_deck
    Card::SUITS.product(Card::FACE_VALUE.keys)
               .map { |suit_face| Card.new(*suit_face) }.shuffle
  end
end
