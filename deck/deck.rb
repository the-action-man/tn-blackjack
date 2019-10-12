class Deck
  attr_reader :cards

  def initialize
    new_deck
  end

  def refresh!
    new_deck
  end

  def take_card
    @cards.shift
  end

  private

  def new_deck
    @cards = generate_new_deck
    @cards.shuffle!
  end

  def generate_new_deck
    new_cards = []
    cards_without_suits = Card.evaluate_cards_without_suits
    Card::SUITS.each do |suit|
      cards_without_suits.each do |name, value|
        new_cards << Card.new("#{name}#{suit}", value)
      end
    end
    new_cards
  end
end
