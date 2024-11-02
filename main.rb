require_relative 'game'
require_relative 'player'
require_relative 'deck'
require_relative 'user'
require_relative 'dealer'

BET = 10

def end_round(game, deck)
  game.result
  deck.pick_up_cards(game.players)
  game.show_players_bank
end

def auto_end_round_check(game, deck)
  return unless game.players_have_three_cards?

  end_round(game, deck)
end

def player_moves(game, deck)
  loop do
    case game.new_move
    when :take_card
      deck.take_card(game.current_player)
    when :show_hand then end_round(game, deck)
    end
    game.next_player
    auto_end_round_check(game, deck)
    break if deck.round_over
  end
end

def new_round(game, deck)
  game.take_bets(BET)
  deck.deal_cards(game.players)
  game.next_player if game.current_player == game.dealer
  player_moves(game, deck)
end

print 'Enter your name: '
game = Game.new(User.new(gets.chomp), Dealer.new, BET)

while game.players_have_money?
  new_round(game, Deck.new)
  print 'Enter to continue or [q] exit: '
  break if gets.chomp.upcase == 'Q'
end

if game.user.money.zero?
  puts 'Sorry 😔, you loose...'
elsif game.dealer.money.zero?
  puts 'Congratulations 🏆, you win this game!'
else
  puts 'Goodbуe friend...👋'
end
