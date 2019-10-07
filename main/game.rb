class Game
  MAX_VALUE = 21

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
  end

  def new_game
    @deck = Deck.new
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
    user_values = calc_cards_values(@user)
    dealer_values = calc_cards_values(@dealer)
    return 0 if user_values > MAX_VALUE && dealer_values > MAX_VALUE
    return 0 if user_values == MAX_VALUE
    return 1 if user_values > dealer_values
    return -1 if user_values < dealer_values
  end

  private

  def calc_cards_values(gamer)
    value = 0
    aces_quantity = 0
    gamer.cards.each do |card|
      value += card.value
      aces_quantity += 1 if card.ace?
    end
    value += 10 if aces_quantity > 1 # Default 1 was added before (1 + 10 = 11)
    value += 10 if aces_quantity == 1 && value + 10 <= MAX_VALUE
    value
  end
end
