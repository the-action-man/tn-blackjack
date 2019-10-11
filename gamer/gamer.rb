class Gamer
  INITIAL_BANK = 100
  BET = 10
  MAX_VALUE = 21

  attr_reader :name, :bank, :cards, :cards_values

  def initialize(name)
    @name = name
    @bank = INITIAL_BANK
    @cards = []
    @cards_values = 0
  end

  def make_bet
    @bank -= BET
  end

  def take_card(card)
    @cards << card
    @cards_values = calc_cards_values
  end

  def take_win
    calc_bank(BET * 2)
  end

  def return_bet
    calc_bank(BET)
  end

  def discard_cards
    @cards = []
  end

  private

  def calc_cards_values
    value = 0
    aces_quantity = 0
    @cards.each do |card|
      value += card.value
      aces_quantity += 1 if card.ace?
    end
    value += 10 if aces_quantity > 1 # Default 1 was added before (1 + 10 = 11)
    value += 10 if aces_quantity == 1 && value + 10 <= MAX_VALUE
    value
  end

  def calc_bank(amount)
    @bank += amount
  end
end
