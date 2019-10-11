class UserInterface
  MAX_DEALER_VALUES_TO_GET_CARD = 17
  CARDS_QUANTITY_TO_OPEN = 3

  def start
    puts 'Hi! It is Blackjack game!'
    puts 'Please, enter your name:'
    user_name = gets.chomp.to_s
    @user = User.new(user_name)
    @dealer = Dealer.new
    @game = Game.new(@user, @dealer)
    exit_game = false

    loop do
      break if exit_game
      break if @game.any_bank_empty?

      puts '   *** NEW GAME (Bet is 10) ***'
      deck = @game.new_game
      2.times { @dealer.take_card(deck.take_card) }
      @dealer.make_bet
      2.times { @user.take_card(deck.take_card) }
      @user.make_bet

      loop do
        @dealer.show_info(false)
        @user.show_info
        puts 'Enter number of game action:'
        puts '0- exit'
        puts '1- skip'
        puts '2- take a card'
        puts '3- open cards'
        case gets.chomp.to_i
        when 0
          exit_game = true
          break
        when 1
          puts 'You selected skip'
        when 2
          if @user.cards.size == CARDS_QUANTITY_TO_OPEN
            put 'You already have 3 cards. It is maximum.'
          else
            @user.take_card(deck.take_card)
            @user.show_info
          end
        when 3
          open_cards
          break
        else
          puts 'Incorrect selection'
        end

        if @dealer.cards.size == CARDS_QUANTITY_TO_OPEN
          'Dealer already have 3 cards'
        else
          if @dealer.cards_values >= MAX_DEALER_VALUES_TO_GET_CARD
            puts 'Dealer do skip'
          else
            @dealer.take_card(deck.take_card)
            puts 'Dealer takes card'
          end
        end
        if @dealer.cards.size == CARDS_QUANTITY_TO_OPEN \
                                  && @user.cards.size == CARDS_QUANTITY_TO_OPEN
          open_cards
          break
        end
      end
    end
  end

  def open_cards
    puts '--- --- Open cards --- ---'
    @dealer.show_info
    @user.show_info
    case @game.user_winner?
    when 1
      @dealer.accept_defeat
      @user.take_win
      msg_prefix = 'You are winner!'
    when 0
      msg_prefix = 'Winner is absent!'
      @dealer.return_bet
      @user.return_bet
      @dealer.discard_cards
      @user.discard_cards
    when -1
      @dealer.take_win
      @user.accept_defeat
      msg_prefix = 'Dealer is winner!'
    end
    puts "#{msg_prefix} Your bank: #{@user.bank}. Dealer bank: #{@dealer.bank}"
    print "--- --- --- --- --- --- ---\n\n"
  end
end
