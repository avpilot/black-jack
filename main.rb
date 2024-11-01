require_relative 'game'
require_relative 'card'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'

print 'Enter your name: '
game = Game.new(User.new(gets.chomp), Dealer.new, 10)
deck = Card.new
deck.deal_cards(game.players)

puts "Your cards: #{game.current_player.cards * ' '}"

case game.current_player.make_choice
when :pass then
  game.next_player.make_choice
  game.show_hand
when :take_card
  deck.take_card(game.current_player)
  game.show_hand
when :show_hand then game.show_hand
end
