class Game
  MAX_VALUE = 21

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
  end

  def new_game
    @deck ||= Deck.new
    @deck.refresh_deck
  end

  def any_bank_empty?
    if @user.bank == 0
      puts "#{@user.name}', your bank is empty'! Dealer is winner!"
      false
    end
    if @dealer.bank == 0
      puts 'Congratulations! Dealer bank is empty! You are winner!!! '
      false
    end
    true
  end

  # The method returns:
  # 1 - yes
  # 0 - values are the same
  # -1 - no
  def user_winner?
    user_values = @user.cards_values
    dealer_values = @dealer.cards_values
    return 0 if user_values > MAX_VALUE && dealer_values > MAX_VALUE
    return 0 if user_values == MAX_VALUE
    return 1 if user_values > dealer_values
    return -1 if user_values < dealer_values
  end
end
