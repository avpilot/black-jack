class Game
  attr_reader :current_player, :players

  def initialize(user, dealer, bet)
    @bank = user.place_bet(bet) + dealer.place_bet(bet)
    @players = [user, dealer]
    @moves_order = @players.cycle
    @current_player = @moves_order.next
    @deck_cards = new_deck
  end

  def next_player
    @current_player = @moves_order.next
  end

  def give_card(player)
    player.take_card(@deck_cards.delete_at(-1))
  end

  def deal_cards
    players.each { |player| 2.times { give_card(player) } }
  end

  def show_hands?
    # To Do
  end

  def show_hand
    players.each do |player|
      puts "#{player.name}: #{player.cards * ' '}, Points: #{player.points}"
    end
  end

  def new_move
    @current_player.make_choice
  end

  private

  def new_deck
    cards = %w[A K Q J].concat (2..10).to_a
    suits = %w[♦️ ♥️ ♠️ ♣️]
    cards.product(suits).map(&:join).shuffle
  end
end
