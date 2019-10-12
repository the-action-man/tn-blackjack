class UserInterface
  attr_reader :user_name

  def show_msg_hello
    puts 'Hi! It is Blackjack game!'
  end

  def enter_user_name
    puts 'Please, enter your name:'
    @user_name = gets.chomp.to_s
  end

  def show_msg_new_game
    print "\n   *** NEW GAME (Bet is 10) ***\n"
  end

  def show_gamer_info(gamer, show_cards = true)
    print "#{gamer.name} - Cards: "
    if show_cards
      gamer.hand.cards.each { |card| print "| #{card.name} |" }
      print " Values=#{gamer.hand.cards_values}"
    else
      gamer.hand.cards.size.times { print '| **** |' }
    end
    print " Bank=#{gamer.bank}\n"
  end

  def enter_user_action
    puts 'Enter number of game action:'
    puts '0- exit'
    puts '1- skip'
    puts '2- take a card'
    puts '3- open cards'
    gets.chomp.to_i
  end

  def show_msg_user_action_skip
    puts 'You selected skip'
  end

  def show_msg_user_takes_card
    puts 'You take card'
  end

  def show_msg_you_have_3_cards
    puts 'You already have 3 cards. It is maximum.'
  end

  def show_msg_incorrect_selection
    puts 'Incorrect selection'
  end

  def show_msg_dealer_has_3_cards
    puts 'Dealer already have 3 cards'
  end

  def show_msg_dealer_do_skip
    puts 'Dealer do skip'
  end

  def show_msg_dealer_takes_card
    puts 'Dealer takes card'
  end

  def show_open_cards(dealer, user, user_status)
    puts '--- --- Open cards --- ---'
    show_gamer_info(dealer)
    show_gamer_info(user)
    case user_status
    when GamerStatus::WINNER
      msg_prefix = 'You are winner!'
    when GamerStatus::DRAWN_GAME
      msg_prefix = 'Winner is absent!'
    when GamerStatus::LOSER
      msg_prefix = 'Dealer is winner!'
    else
      raise BlackjackError, "'#{user_status}' is incorrect status value. " \
                            'Expected values: -1...1'
    end
    puts "#{msg_prefix} Your bank: #{user.bank}. Dealer bank: #{dealer.bank}"
    print "--- --- --- --- --- --- ---\n\n"
  end

  def show_msg_dealer_is_winner
    puts "#{@user_name}', your bank is empty'! Dealer is winner!"
  end

  def show_msg_user_is_winner
    puts 'Congratulations! Dealer bank is empty! You are winner!!!'
  end
end
