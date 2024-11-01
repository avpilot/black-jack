class Player
  attr_reader :name, :cards, :points, :money

  INITIAL_BANK = 100
  NUMERALS_CARD = /^([1-9]|10)$/

  def initialize(name)
    @name = name
    @money = INITIAL_BANK
    @points = 0
    @cards = []
    @current_game = nil
  end

  def place_bet(bet)
    @money -= bet
    bet
  end

  def gain_money(win)
    @money += win
  end

  def new_card(card)
    cards << card
    @points += card_points(card)
  end

  def fold_cards
    @cards = []
    @points = 0
  end

  def make_choice
    raise 'should be emplemented in subclasses'
  end

  def card_points(card)
    card_value = card.slice(...-2)
    if card_value.match(NUMERALS_CARD)
      card_value.to_i
    elsif card_value == 'A'
      @points > 10 ? 1 : 11
    else
      10
    end
  end
end
