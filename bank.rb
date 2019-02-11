require_relative 'player.rb'
class Bank
  BET = 10

  attr_reader :value

  def make_bet(player, dealer)
    player.make_bet(BET)
    dealer.make_bet(BET)
    @value = BET * 2
  end

  def refund(player, dealer)
    refund_amount = value / 2.0
    player.refund_bet(refund_amount)
    dealer.refund_bet(refund_amount)
    @value = 0
  end

  def reward_winner(player)
    player.win_bank(value)
    @value = 0
  end

  def can_make_bet?(player)
    player.balance >= BET
  end
end
