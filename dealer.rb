class Dealer < Player
  MAX_POINT_TO_PLAY = 17

  def initialize(name = 'Dealer')
    super(name)
  end

  def make_choice
    @points >= MAX_POINT_TO_PLAY ? :pass : :take_card
  end
end
