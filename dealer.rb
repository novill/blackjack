require_relative 'player.rb'
class Dealer < Player
  MIN_DEALDER_LIMIT = 17
  def initialize
    super('Дилер')
  end

  def should_get_card?
    !hand.full? && hand.card_sum < MIN_DEALDER_LIMIT
  end
end
