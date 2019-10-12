class Gamer
  INITIAL_BANK = 100
  BET = 10

  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = INITIAL_BANK
    @hand = Hand.new
  end

  def make_bet
    @bank -= BET
  end

  def take_win
    calc_bank(BET * 2)
  end

  def return_bet
    calc_bank(BET)
  end

  private

  def calc_bank(amount)
    @bank += amount
  end
end
