class Game
  attr_reader :current_player, :players, :user, :dealer

  def initialize(user, dealer, _bet)
    @players = [user, dealer]
    @user = user
    @dealer = dealer
    @bank = 0
    @moves_order = @players.cycle
    @current_player = @moves_order.next
  end

  def take_bets(bet)
    @bank = user.place_bet(bet) + dealer.place_bet(bet)
  end

  def next_player
    @current_player = @moves_order.next
  end

  def new_move
    show_user_cards if current_player == user
    current_player.make_choice
  end

  def result
    puts '*' * 80
    show_players_cards
    reward_result(winner)
    puts '*' * 80
  end

  def reward_result(winner)
    if draw?
      puts '!!! Draw !!!'.center(80)
      players.each { |player| player.gain_money(@bank / 2) }
    else
      puts "!!! #{winner.name.upcase} win game bank #{@bank}$ !!!".center(80)
      winner.gain_money(@bank)
      @bank = 0
    end
  end

  def winner
    return players.min { |p1, p2| p1.points <=> p2.points } if any_overkill?

    players.min { |p1, p2| (21 - p1.points) <=> (21 - p2.points) }
  end

  def draw?
    everyone_overkill? || evryone_same_points? ? true : false
  end

  def everyone_overkill?
    players.all? { |player| player.points > 21 }
  end

  def any_overkill?
    players.any? { |player| player.points > 21 }
  end

  def evryone_same_points?
    players.map(&:points).uniq.length == 1
  end

  def show_user_cards
    puts "\n#{dealer.name.rjust(8)}: #{'🂠 ' * dealer.cards.count}"
    puts "#{user.name.rjust(8)}: #{user.cards * ' '}  Points: #{user.points}"
  end

  def show_players_cards
    players.each do |player|
      puts "#{player.name}: #{player.cards * ' '}  Points: #{player.points}".center(80)
    end
  end

  def show_players_bank
    players.each { |player| puts "#{player.name} bank: #{player.money}$," }
  end

  def players_have_three_cards?
    players.all? { |player| player.cards.count == 3 }
  end

  def players_have_money?
    players.all? { |player| player.money.positive? }
  end
end
