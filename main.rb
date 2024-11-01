require_relative 'game'
require_relative 'player'
require_relative 'card'
require_relative 'user'
require_relative 'dealer'

BET = 10

def players_has_three_cards?(game)
  game.players.all? { |player| player.cards.count == 3 }
end

def players_has_money?(game)
  game.players.all? { |player| player.money > 0 }
end

def end_round(game, deck)
  game.result
  deck.pick_up_cards(game.players)
  game.show_players_bank
end

print 'Enter your name: '
game = Game.new(User.new(gets.chomp), Dealer.new, BET)


while players_has_money?(game)
  game.take_bets(BET)
  deck = Card.new
  deck.deal_cards(game.players)
  game.show_user_cards
  loop do
    case game.current_player.make_choice
    when :pass then game.next_player
    when :take_card
      deck.take_card(game.current_player)
      game.show_user_cards
      game.next_player
    when :show_hand
      end_round(game, deck)
      break
    end

    if players_has_three_cards?(game)
      end_round(game, deck)
      break
    end
  end

  print 'Continue? [y/n]: '
  break if gets.chomp.upcase == 'N'
end
