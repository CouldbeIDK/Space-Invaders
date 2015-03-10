#! usr/bin/env/ruby

require 'gosu'
require 'test/unit'

class GameWindow < Gosu::Window

	def initialize
	end
	
	def update
	end
	
	def draw
	end

end #GameWindow

class Game

	attr_accessor :invaders
	attr_accessor :playerShip
	attr_accessor :lasers
	
	def initialize()
		@invaders = Array.new
		@playerShip = PlayerShip.new
		@lasers = Array.new
		
		spawnInvaders
	end
	
	def spawnInvaders
		for i in 1..4
			@invaders << SpaceInvader.new()
		end
	end
	
	def victory?
		if @invaders.count == 0
			return true
		end
		return false
	end
	
	def defeat?
		if @invaders[0].location == "bottom"
			return true
		end
		return false
	end
	
	def checkCollisions
	end
	
	def moveObjects
	end
	
	def turnInvaders
		@invaders.each do |i|
			@invaders[i].turnAround()
		end
	end

end #Game

class SpaceObject
	
	attr_accessor :location
	attr_accessor :structure
	attr_accessor :velocity
	
	def draw()
	end
	
end

class PlayerShip < SpaceObject
	
	def fire()
	end
	
end

class SpaceInvader < SpaceObject
	
	def turnAround()
	end
	
end

class Laser < SpaceObject
end

######################################################################################

class Testing < Test::Unit::TestCase


	def setup
		@game = Game.new
	end
	def test_game
		assert_equal(4, @game.invaders.count , "Error: spawnInvaders.")
		assert_equal(false, @game.victory?, "Error: victory? false")
		assert_equal(false, @game.defeat?, "Error: defeat? false")
		@game.invaders[0].location = "bottom"
		assert_equal(true, @game.defeat?, "Error: defeat? true")
		for i in 0..3
			@game.invaders.delete_at(0)
		end
		assert_equal(true, @game.victory?, "Error : victory? true")
	end
	
end