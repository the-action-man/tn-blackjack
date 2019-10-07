class Card
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ace?
    @name.start_with?('ace')
  end
end
