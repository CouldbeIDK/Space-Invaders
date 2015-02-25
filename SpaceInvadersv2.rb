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
	def initialize(location, structure)
		@location = location
		@structure = structure
		@velocity = 0
	end
	def draw
	end
end #SpaceObject

class PlayerShip < SpaceObject
	def fire()
	end
end #PlayerShip

class SpaceInvader < SpaceObject
	def initialize(location, structure, index)
		@index = index
		super.initialize(location, structure)
	end
	def turnAround()
	end
end #SpaceInvader

module BoundingBox
	attr_reader :x :y :width :height
	def inside?(point)
		
		