#! usr/bin/env/ruby

require 'gosu'

$playerSpeed = 5
$invaderSpeed = 2
$laserSpeed = 10

class GameWindow < Gosu::Window
	
	attr_accessor :game
	
	def initialize
		super(480, 640, false)
		self.caption = "Space Invaders"
		@game = Game.new(self)
	end
	
	def update
		
		if @game.checkForEnd
			self.close
		end
		
		if button_down? Gosu::KbLeft then
			@game.playerShip.velocity = -1
		end
		
		if button_down? Gosu::KbRight then
			@game.playerShip.velocity = 1
		end
		
		if button_down? Gosu::KbSpace
			@game.playerShip.fire
		end
		
		@game.turnInvaders
		@game.moveObjects
		@game.checkCollisions
		@game.playerShip.velocity = 0
		@game.cleanUp
	end
	
	def draw
		@game.invaders.each { |invader| invader.draw() }
		@game.playerShip.draw()
		@game.lasers.each { |laser| laser.draw() }
	end

end #GameWindow

class Game

	attr_accessor :invaders
	attr_accessor :playerShip
	attr_accessor :lasers
	
	def initialize(window)
		@window = window
	
		@invaders = Array.new
		@playerShip = PlayerShip.new( 218 , 600 , @window )
		@lasers = Array.new
		
		
		spawnInvaders
	end
	
	def spawnInvaders
		for i in 1..4
			@invaders << SpaceInvader.new( i * 100 - 32 , 0 , @window)
		end
	end
	
	def victory?
		if @invaders.count == 0
			return true
		end
		return false
	end
	
	def defeat?
		if @invaders.last.y >= 600
			return true
		end
		return false
	end
	
	def checkCollisions
	end
	
	def moveObjects
		@invaders.each { |invader| invader.x += invader.velocity * $invaderSpeed }
		@playerShip.x += playerShip.velocity * $playerSpeed
		@lasers.each { |laser| laser.y -= laser.velocity * $laserSpeed}
	end
	
	def turnInvaders
		x = 0
		for i in @invaders
			@invaders[x].turnAround
			x = x + 1
		end
	end
	
	def checkForEnd
		
		if victory? or defeat?
			return true
		else
			return false
		end
	
	end
	
	def cleanUp
		x = 0
		for laser in @lasers
			if laser.y <= 100
				@lasers[x] = nil
			end
			x = x + 1
		end
		
		@lasers.compact!
				
	end

end #Game

class SpaceObject
	
	attr_accessor :x
	attr_accessor :y
	attr_accessor :structure
	attr_accessor :velocity
	
	def initialize( x , y , window)
		@x = x
		@y = y
		@z = 1
		@window = window
		@velocity = 0
	end
	
	def draw( xf , yf )
		@structure.draw( @x , @y, @z , xf , yf )
	end
	
end #SpaceObject

class PlayerShip < SpaceObject
		
	def initialize ( x , y , window )
		super	
		@window = window
		@structure = Gosu::Image.new(@window, "Space_Invaders_Ship.png", false)
		@xf = 0.5
		@yf = 0.5
	end
	
	def draw()
		super(@xf , @yf)
	end
	
	def fire()
		@window.game.lasers.push(Laser.new( @x + 18 , @y , @window ))
	end
	
end #PlayerShip

class SpaceInvader < SpaceObject

	def initialize ( x , y , window )
		super
		@z = 3
		@structure = Gosu::Image.new( window , "Space_Invader.png" , false )
		@velocity = 1
		@xf = 0.5
		@yf = 0.5
	end
	
	def draw()
		super(@xf , @yf)
	end
	
	def turnAround()
		if @x > 422
			@y = @y + 50
			@velocity = -1
			@x = 420
		elsif @x < 0
			@y = @y + 50
			@velocity = 1
			@x = 2
		end
	end
	
end #SpaceInvader

class Laser < SpaceObject

	def initialize( x , y , window )
		super
		@z = 2
		@structure = Gosu::Image.new( window , "Circle.png" , false )
		@xf = 0.1
		@yf = 0.1
		@velocity = 1
	end
	
	def draw()
		super( @xf , @yf )
	end
	
end

######################################################################################

$The_Game = GameWindow.new()
$The_Game.show()