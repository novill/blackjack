# frozen_string_literal: true

class Card
  FACE_VALUE = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 11
  }.freeze
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  ACE_CORRECTION = 10

  attr_reader :suit, :face, :masked

  def initialize(suit, face)
    @suit = suit
    @face = face
    @value = FACE_VALUE[face]
    @masked = true
  end

  attr_reader :value

  def ace?
    @value == 11
  end

  def unmask
    @masked = false
    self
  end

  def to_s
    if @masked
      '**'
    else
      "#{@face}#{@suit}"
    end
  end
end
