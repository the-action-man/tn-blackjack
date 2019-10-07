class Deck
  attr_reader :cards

  def initialize
    new_game
  end

  def take_card
    @cards.shift
  end

  private

  def new_game
    @cards = new_deck
    @cards.shuffle
  end

  def new_deck
    new_cards = []
    cards_without_suits = evaluate_cards_without_suits
    suits = %w[+ <3 ^ <>]
    suits.each do |suit|
      cards_without_suits.each do |name, value|
        new_cards << Card.new("#{name}#{suit}", value)
      end
    end
    new_cards
  end

  def evaluate_cards_without_suits
    cards = {}
    (2..10).each { |value| cards[value.to_s] = value }
    cards['jack'] = 10
    cards['queen'] = 10
    cards['king'] = 10
    cards['ace'] = 1
    cards
  end
end
