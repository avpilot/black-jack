class Game
  attr_reader :current_player, :players

  def initialize(user, dealer, bet)
    @bank = user.place_bet(bet) + dealer.place_bet(bet)
    @players = [user, dealer]
    @moves_order = @players.cycle
    @current_player = @moves_order.next
    # @cards = Card.new
    # deal_cards(@players)
  end

  def next_player
    @current_player = @moves_order.next
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
end
