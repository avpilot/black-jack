class Game
  attr_reader :current_player, :players, :user, :dealer


  def initialize(user, dealer, bet)
    @players = [user, dealer]
    @user = user
    @dealer = dealer
    @bank = take_bets(bet)
    @moves_order = @players.cycle
    @current_player = @moves_order.next
  end

  def take_bets(bet)
    @bank = user.place_bet(bet) + dealer.place_bet(bet)
  end

  def next_player
    @current_player = @moves_order.next
  end

  def result
    show_players_cards
    if players.all? { |player| player.points > 21 } ||
       players.map(&:points).uniq.length == 1
      puts 'No winners!'
      players.each { |player| player.gain_money(@bank / 2) }
    elsif user.points > 21 || dealer.points > 21
      winner = players.min { |pl1, pl2| pl1.points <=> pl2.points }
    else
      winner = players.min { |pl1, pl2| (21 - pl1.points) <=> (21 - pl2.points) }
    end

    return if winner.nil?

    puts "#{winner.name} win!"
    winner.gain_money(@bank)
    @bank = 0
  end

  def show_user_cards
    puts
    puts "  #{dealer.name}: #{'🂠 ' * dealer.cards.count}"
    puts "  #{user.name}: #{user.cards * ' '}  Points: #{user.points}"
    puts
  end

  def show_players_cards
    puts
    players.each do |player|
      puts "  #{player.name}: #{player.cards * ' '}  Points: #{player.points}"
    end
    puts '********'
  end

  def show_players_bank
    puts "  #{dealer.name} bank: #{dealer.money}"
    puts "  #{user.name} bank: #{user.money}"
  end

  def new_move
    @current_player.make_choice
  end
end
