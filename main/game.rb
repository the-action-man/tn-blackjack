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
      break if @exit_game
      break if any_bank_empty?

      do_game
    end
  end

  private

  def take_cards
    @deck.refresh! if @deck.cards.size < MINIMUM_CARDS_FOR_ONE_GAME
    2.times { @dealer.take_card(@deck.take_card) }
    2.times { @user.take_card(@deck.take_card) }
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
      break if @exit_game
      break if @open_cards_occurs

      do_game_actions
    end
  end

  def do_game_actions
    @ui.show_gamer_info(@dealer, false)
    @ui.show_gamer_info(@user)
    handle_user_action
    return if @exit_game
    return if @open_cards_occurs

    handle_dealer_action
    if @dealer.cards.size == CARDS_QUANTITY_TO_OPEN \
                                  && @user.cards.size == CARDS_QUANTITY_TO_OPEN
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
      if @user.cards.size == CARDS_QUANTITY_TO_OPEN
        @ui.show_msg_you_have_3_cards
      else
        @user.take_card(@deck.take_card)
        @ui.show_msg_user_takes_card
      end
    when 3
      open_cards
    else
      @ui.show_msg_incorrect_selection
    end
  end

  def handle_dealer_action
    if @dealer.cards.size == CARDS_QUANTITY_TO_OPEN
      @ui.show_msg_dealer_has_3_cards
    elsif @dealer.cards_values >= MAX_DEALER_VALUES_TO_GET_CARD
      @ui.show_msg_dealer_do_skip
    else
      @dealer.take_card(@deck.take_card)
      @ui.show_msg_dealer_takes_card
    end
  end

  def open_cards
    is_user_winner = define_user_winner_status
    case is_user_winner
    when 1
      @user.take_win
    when 0
      @dealer.return_bet
      @user.return_bet
    when -1
      @dealer.take_win
    else
      raise BlackjackError, "'#{is_user_winner}' is incorrect winner value. " \
                            'Expected values: 1, 0, -1.'
    end
    @ui.show_open_cards(@dealer, @user, is_user_winner)
    @dealer.discard_cards
    @user.discard_cards
    @open_cards_occurs = true
  end

  # The method returns:
  # 1 - yes, winner
  # 0 - values are the same
  # -1 - no, defeat
  def define_user_winner_status
    user_values = @user.cards_values
    dealer_values = @dealer.cards_values
    return 0 if user_values > MAX_VALUE && dealer_values > MAX_VALUE
    return -1 if user_values > MAX_VALUE && dealer_values <= MAX_VALUE
    return 1 if user_values <= MAX_VALUE && dealer_values > MAX_VALUE
    return 0 if user_values == dealer_values
    return 1 if user_values > dealer_values
    return -1 if user_values < dealer_values
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
