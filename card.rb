# frozen_string_literal: true

class Card
  FACE = %w[2 3 4 5 6 7 8 9 10 В Д К Т].freeze
  VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze
  SUIT = %w[+ <3 ^ <>].freeze

  attr_reader :suit, :face

  def initialize(card_index)
    @suit, @face = card_index.divmod(13)
  end

  def to_s
    "#{FACE[@face]}#{SUIT[@suit]}"
  end

  def ace?
    @face == FACE[-1]
  end

  def value
    VALUE[@face]
  end
end
