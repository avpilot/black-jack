class Dealer < Player
  MAX_POINT_TO_PLAY = 17

  def initialize
    super('Dealer')
  end

  def make_choice
    :take_card
    :pass if @points >= MAX_POINT_TO_PLAY
  end
end
