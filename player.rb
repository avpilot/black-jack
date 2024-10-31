class Player
  attr_reader :name, :cards, :points

  INITIAL_BANK = 100

  def initialize(name)
    @name = name
    @money = INITIAL_BANK
    @points = 0
    @cards = []
    @current_game = nil
  end

  def place_bet(bet)
    @money += bet
    bet
  end

  def gain_money(win)
    @money += win
  end

  def take_card(card)
    cards << card
    @points += 1
  end

  def make_choice
    raise 'should be emplemented in subclasses'
  end
end
