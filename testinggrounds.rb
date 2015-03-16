require 'gosu'

class GameWindow < Gosu::Window

	def initialize
		super(480, 640, false)
		self.caption = "Testing Grounds"
		@ship = PlayerShip.new( 240 , 320 , self )
	end
	
	def update
	
	end
	
	def draw
			@ship.draw()
	end
	
end
	
class SpaceObject
	
	attr_accessor :x
	attr_accessor :y
	attr_accessor :structure
	attr_accessor :velocity
	
	def initialize( x , y , window)
		@x = x
		@y = y
		@window = window
	end
	
	def draw()
		@structure.draw( @x , @y, 2 )
	end
	
end

class PlayerShip < SpaceObject
		
	def initialize ( x , y , window )
		super	
		@structure = Gosu::Image.new(window, "Space_Invaders_Ship.png", false)
	end
	
	def fire()
	end
	
end

window = GameWindow.new()
window.show()