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

class Player

	attr_reader :total_score

	def initialize
		@total_score = 0
	end
	def add(score)
		@total_score += score
	end
end

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

puts "Input the number of players going to play the game: "
player_count = gets.chomp.to_i

game = Game.new(player_count)

# pos = -1
# final_count = player_count

# while final_count >= 

first = -1
while true
	i = 1
	final = "not done"
	game.players.each do |player|
		non_scoring = 5
		temp_score = 0
		ch = "y"
		while ch == "y"
			dice = DiceSet.new
			dice.roll(non_scoring)
			score, hash = game.scoring(dice.values)
			temp_score += score
			puts "dice values : #{dice.values}"
			puts "temp score : #{temp_score}"
			puts "total_score : #{player.total_score}"
			break if score == 0
			non_scoring = game.count_non_scoring(hash)
			non_scoring = 5 if non_scoring == 0
			puts "non_scoring : #{non_scoring}"
			puts "Do you want to continue your turn?(y/n)"
			ch = gets.chomp
		end
		temp_score = 0 if score == 0
		i += 1

		puts "-------------------------------------------------------------"

		next if temp_score < 300 && player.total_score == 0

		if first == i - 1
			final = "done"
			break		
		end
		player.add(temp_score)
		first = i - 1 if player.total_score >= 3000
	end
	break if final == "done"
	game.players.each do |player|
		puts player.total_score
	end
end

game.players.each do |player|
	puts player.total_score
end