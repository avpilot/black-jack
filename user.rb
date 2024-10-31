class User < Player
  def make_choice
    puts '1: Pass, 2: Take a card, 3: Show a hand'
    print 'Select your action: '
    case gets.chomp.to_i
    when 1 then :pass
    when 2 then :take_card
    when 3 then :show_hand
    else raise 'Unknown action'
    end
  rescue StandardError
    retry
  end
end
