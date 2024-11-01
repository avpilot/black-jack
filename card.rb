class Card
  def initialize
    @cards = new_deck
  end

  def take_card(player)
    player.take_card(@cards.delete_at(-1))
    @cards = new_deck if @cards.empty?
  end

  def deal_cards(players)
    players.each { |player| 2.times { take_card(player) } }
  end

  private

  def new_deck
    cards = %w[A K Q J].concat (2..10).to_a
    suits = %w[♦️ ♥️ ♠️ ♣️]
    cards.product(suits).map(&:join).shuffle
  end
end