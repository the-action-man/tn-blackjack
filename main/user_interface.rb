class UserInterface

  def start
    puts 'Hi! It is Blackjack game!'
    puts 'Please, enter your name:'
    user_name = gets.chomp.to_s
    user = User.new(user_name)
    dealer = Dealer.new
    game = Game.new(user, dealer)

    loop do
      break if game.any_bank_empty?

      deck = game.new_game
      2.times { dealer.take_card(deck.take_card) }
      dealer.make_bet
      dealer.show_info(false)
      2.times { user.take_card(deck.take_card) }
      user.make_bet
      user.show_info




      case selected_menu_item
      when 0
        break
      when 1
        #TODO
      when 101
        #TODO
      else
        puts 'Incorrect selection'
      end
    end
  end
end
