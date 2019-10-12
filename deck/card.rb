class Card
  SUITS = %w[+ <3 ^ <>].freeze
  JACK = 'jack'.freeze
  QUEEN = 'queen'.freeze
  KING = 'king'.freeze
  ACE = 'ace'.freeze
  FACE_CARD_VALUE = 10
  DEFAULT_ACE_VALUE = 1

  attr_reader :name, :value

  def self.evaluate_cards_without_suits
    cards = {}
    (2..10).each { |value| cards[value.to_s] = value }
    cards[JACK] = FACE_CARD_VALUE
    cards[QUEEN] = FACE_CARD_VALUE
    cards[KING] = FACE_CARD_VALUE
    cards[ACE] = DEFAULT_ACE_VALUE
    cards
  end

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ace?
    @name.start_with?(ACE)
  end
end
