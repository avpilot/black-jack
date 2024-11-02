class User < Player
  def make_choice
    print "\n1: Pass, 2: Take card, 3: Show cards\nSelect your action: "
    case gets.chomp.to_i
    when 1 then :pass
    when 2 then :take_card
    when 3 then :show_hand
    else raise 'Unknown action'
    end
  rescue StandardError => e
    puts "Exception: #{e.message}, try again..."
    retry
  end
end
