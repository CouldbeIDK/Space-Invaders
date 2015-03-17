require_relative 'BunnyInvadersClasses'
require 'test/unit'


class GameWindow < Gosu::Window

end

class Testing < Test::Unit::TestCase


	def setup
		@game = Game.new(GameWindow.new(2 , 2 , false))
	end
	def test_game
		assert_equal(4, @game.invaders.count , "Error: spawnInvaders.")
		assert_equal(false, @game.victory?, "Error: victory? false")
		assert_equal(false, @game.defeat?, "Error: defeat? false")
		@game.invaders.last.y = 610
		assert_equal(true, @game.defeat?, "Error: defeat? true")
		for i in 0..3
			@game.invaders.delete_at(0)
		end
		assert_equal(true, @game.victory?, "Error : victory? true")
	end
	
end