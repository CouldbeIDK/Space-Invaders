/
Space Invaders take two
/

class GameWindow < Gosu::Window
	def initialize
	end
	def update
	end
	def draw
	end
	def checkCollisions
	end
end #GameWindow

class Game
	attr_accessor :score
	attr_accessor :invaders
	attr_accessor :playerShip
	attr:accessor :lasers
	def initialize
	end
	def victory
	end
	def defeat
	end
	def moveObjects
	end
	def turnInvaders
	end
end #Game

class SpaceObject
	def initialize
	end
	def draw
	end
end #SpaceObject