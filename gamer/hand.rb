class Hand
  MAX_VALUE = 21

  attr_reader :cards, :cards_values

  def initialize
    @cards = []
    @cards_values = 0
  end

  def take_card(card)
    @cards << card
    @cards_values = calc_cards_values
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
end
