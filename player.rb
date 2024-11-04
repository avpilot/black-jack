class Player
  attr_reader :name, :cards, :points, :money

  INITIAL_BANK = 100

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

  def gain_money(game_bank)
    @money += game_bank
  end

  def new_card(card)
    cards << card
    @points += card_points(card)
    recalculate_overkill_ace_points if @points > 21
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
    if card_value.match(/^([1-9]|10)$/)
      card_value.to_i
    else
      card_value == 'A' ? 11 : 10
    end
  end

  def recalculate_overkill_ace_points
    aces = @cards.select { |a_card| a_card.start_with?('A') }
    until aces.empty?
      @points -= 10
      break if @points <= 21
    end
  end
end
