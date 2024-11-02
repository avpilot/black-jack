class Deck
  attr_reader :round_over

  def initialize
    @cards = new_shuffled_deck
    @round_over = false
  end

  def take_card(player)
    if player.cards.count < 3
      player.new_card(@cards.delete_at(-1))
      @cards = new_shuffled_deck if @cards.empty?
    else
      puts "Sorry, You can't take any more."
    end
  end

  def deal_cards(players)
    players.each { |player| 2.times { take_card(player) } }
  end

  def pick_up_cards(players)
    players.map(&:fold_cards)
    @round_over = true
  end

  private

  def new_shuffled_deck
    cards = %w[A K Q J].concat (2..10).to_a
    suits = %w[♦️ ♥️ ♠️ ♣️]
    cards.product(suits).map(&:join).shuffle
  end
end
