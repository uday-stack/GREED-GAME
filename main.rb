require './game.rb'
require './dice.rb'
require './player.rb'

puts "Input the number of players going to play the game: "
player_count = gets.chomp.to_i

game = Game.new(player_count)

first = -1
round = :playing
i = 0
while round == :playing
	game.players.each do |player|
		i += 1
		round = :done and break if first == i
		puts "This is the turn of player #{i}"
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

		puts "-------------------------------------------------------------"

		next if temp_score < 300 && player.total_score == 0
		player.add(temp_score)
		first = i if player.total_score >= 3000
	end

	i = 0

	game.players.each do |player|
		i += 1
		puts "Player #{i} has score: "
		puts player.total_score
	end
	i = 0
end

puts "-------------------------------------------------------------"
puts "Final Scores : "

game.players.each do |player|
		i += 1
		puts "Player #{i} has score: "
		puts player.total_score
	end

winner = game.players.max_by {|player|  player.total_score}
puts "Player #{game.players.find_index(winner) + 1} with score #{winner.total_score} wins!"