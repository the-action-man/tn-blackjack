class Card
  SUITS = %w[+ <3 ^ <>].freeze
  JACK = 'jack'.freeze
  QUEEN = 'queen'.freeze
  KING = 'king'.freeze
  ACE = 'ace'.freeze

  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ace?
    @name.start_with?(ACE)
  end
end
