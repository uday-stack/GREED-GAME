class Game

	attr_accessor :players

	def initialize(count)
		@players = Array.new(count) { Player.new }
	end
	def scoring(dice_values)
  		hash = Hash.new(0)
  		dice_values.each do |value|
  			hash[value] += 1
  		end

  		score = hash[1]/3 * 1000 + hash[1]%3 * 100
  		hash[1] = 0

  		hash.each do |key, val|
  			score += val/3 * 100 * key
  			hash[key] = val%3
  		end

  		score += hash[5] * 50
  		hash[5] = 0
  		return score, hash
 	end

 	def count_non_scoring(hash)
 		count = 0
 		hash.each do |key, val|
 			count += val
 		end
 		count
 	end
end