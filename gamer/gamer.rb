class Gamer
  INITIAL_BANK = 100
  BET = 10

  attr_reader :name, :bank, :cards

  def initialize(name)
    @name = name
    @bank = INITIAL_BANK
    @cards = []
  end

  def make_bet
    @bank -= BET
  end

  def take_card(card)
    @cards << card
  end

  def calc_bank(amount)
    @bank += amount
  end

  def show_info(show_cards = true)
    print "#{@name} - Cards: "
    if show_cards
      @cards.each { |card| print "| #{card.name} |" }
    else
      @cards.size.times { print '| **** |' }
    end
    print " Bank: #{@bank}\n"
  end
end
