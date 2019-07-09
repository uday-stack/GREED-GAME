class Player

	attr_reader :total_score

	def initialize
		@total_score = 0
	end
	def add(score)
		@total_score += score
	end
end