require_relative 'game'
require_relative 'player'
require_relative 'card'
require_relative 'user'
require_relative 'dealer'

print 'Enter your name: '
game = Game.new(User.new(gets.chomp), Dealer.new, 10)

loop do
  deck = Card.new
  deck.deal_cards(game.players)
  game.show_user_cards
  loop do
    case game.current_player.make_choice
    when :pass
      case game.next_player.make_choice
      when :take_card
        deck.take_card(game.current_player)
        game.show_user_cards
      end
    when :take_card
      deck.take_card(game.current_player)
      game.show_user_cards
    when :show_hand
      game.result
      deck.pick_up_cards(game.players)
      break
    end
  end

  print 'Continue? [y/n]: '
  break if gets.chomp.upcase == 'N'
end
