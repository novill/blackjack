# frozen_string_literal: true

require_relative 'hand.rb'
require_relative 'bank.rb'

class Player
  MAX_POINTS = 21
  CARDS_LIMIT = 3

  attr_reader :name, :hand, :balance

  def initialize(name)
    @name = name
    @hand = Hand.new
    @balance = 100
  end

  def make_bet(value)
    @balance -= value
  end

  def refund_bet(value)
    @balance += value
  end

  def win_bank(bank)
    @balance += bank
  end

  alias to_s name
end
