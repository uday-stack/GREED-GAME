class DiceSet
  attr_reader :values
  def roll(a)
    i=1
    @values = []
    while i <= a 
      @values << rand(1..6)
      i += 1 
    end
  end
end