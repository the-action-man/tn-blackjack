class Game
  MAX_DEALER_VALUES_TO_GET_CARD = 17
  CARDS_QUANTITY_TO_OPEN = 3
  MINIMUM_CARDS_FOR_ONE_GAME = 6
  MAX_VALUE = 21

  def initialize(ui)
    @ui = ui
  end

  def initialize_start
    @user = User.new(@ui.user_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @exit_game = false
  end

  def start
    initialize_start

    loop do
      break if @exit_game || any_bank_empty?

      do_game
    end
  end

  private

  def take_cards
    @deck.refresh! if @deck.cards.size < MINIMUM_CARDS_FOR_ONE_GAME
    2.times { @dealer.hand.take_card(@deck.take_card) }
    2.times { @user.hand.take_card(@deck.take_card) }
  end

  def make_bet
    @dealer.make_bet
    @user.make_bet
  end

  def do_game
    @ui.show_msg_new_game
    make_bet
    take_cards
    @open_cards_occurs = false
    loop do
      break if @exit_game || @open_cards_occurs

      do_game_actions
    end
  end

  def do_game_actions
    @ui.show_gamer_info(@dealer, false)
    @ui.show_gamer_info(@user)
    handle_user_action
    return if @exit_game || @open_cards_occurs

    handle_dealer_action
    if @dealer.hand.cards.size == CARDS_QUANTITY_TO_OPEN \
                          && @user.hand.cards.size == CARDS_QUANTITY_TO_OPEN
      open_cards
    end
  end

  def handle_user_action
    case @ui.enter_user_action
    when 0
      @exit_game = true
    when 1
      @ui.show_msg_user_action_skip
    when 2
      if @user.hand.cards.size == CARDS_QUANTITY_TO_OPEN
        @ui.show_msg_you_have_3_cards
      else
        @user.hand.take_card(@deck.take_card)
        @ui.show_msg_user_takes_card
      end
    when 3
      open_cards
    else
      @ui.show_msg_incorrect_selection
    end
  end

  def handle_dealer_action
    if @dealer.hand.cards.size == CARDS_QUANTITY_TO_OPEN
      @ui.show_msg_dealer_has_3_cards
    elsif @dealer.hand.cards_values >= MAX_DEALER_VALUES_TO_GET_CARD
      @ui.show_msg_dealer_do_skip
    else
      @dealer.hand.take_card(@deck.take_card)
      @ui.show_msg_dealer_takes_card
    end
  end

  def open_cards
    user_status = define_user_status
    case user_status
    when GamerStatus::WINNER
      @user.take_win
    when GamerStatus::DRAWN_GAME
      @dealer.return_bet
      @user.return_bet
    when GamerStatus::LOSER
      @dealer.take_win
    else
      raise BlackjackError, "'#{user_status}' is incorrect winner value. " \
                            'Expected values: 1, 0, -1.'
    end
    @ui.show_open_cards(@dealer, @user, user_status)
    @dealer.hand.discard_cards
    @user.hand.discard_cards
    @open_cards_occurs = true
  end

  def define_user_status
    user_values = @user.hand.cards_values
    dealer_values = @dealer.hand.cards_values
    return GamerStatus::DRAWN_GAME if user_values > MAX_VALUE \
                                      && dealer_values > MAX_VALUE
    return GamerStatus::LOSER if user_values > MAX_VALUE \
                                 && dealer_values <= MAX_VALUE
    return GamerStatus::WINNER if user_values <= MAX_VALUE \
                                  && dealer_values > MAX_VALUE
    return GamerStatus::DRAWN_GAME if user_values == dealer_values
    return GamerStatus::WINNER if user_values > dealer_values
    return GamerStatus::LOSER if user_values < dealer_values
  end

  def any_bank_empty?
    if @user.bank.zero?
      @ui.show_msg_dealer_is_winner
      true
    end
    if @dealer.bank.zero?
      @ui.show_msg_user_is_winner
      true
    end
    false
  end
end
