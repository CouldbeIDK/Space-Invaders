require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super(480, 640, false)
		self.caption = "Space Invaders"
		@ship = Ship.new(240, 600, 1)
	end

	def update
	end

	def draw
		@ship.structure:draw(*ship.location)
	end
end

class Game
	attr_accessor :score
	attr_accessor :invaders
	attr_accessor :playership
	attr_accessor :lasers

	def initialize()
		@score = 0
		@invaders = []
		@playership = Ship.new()
		@lasers = []
	end

	def victory()
		return 1
	end
	def defeat()
		return 1
	end
	def checkCollisions()
		return 1
	end
end #Game

class Invader
	attr_accessor :location
	attr_accessor :structure
	def initialize
		@location = [
	end
end #Invader

class Ship
	attr_accessor :location
	attr_accessor :structure
	def initialize(x,y,z)
		@location = [x,y,z]
		@structure = Gosu::Image.new(self, "Space_Invaders_Ship.png", false)
	end
end #Ship

class Laser
	attr_accessor :location
	attr_accessor :structure
end #Laser

/
class Testing < Test::Unit::TestCase


	def setup
		@game = Game.new
	end
	def test_game
		assert_equal(1, @game.tick(), "I don't even know how you could've messed this up.")
	end
end
/

window = GameWindow.new
window.show