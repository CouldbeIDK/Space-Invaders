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
			if @game.laser == nil
				@game.playerShip.fire
			end
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
		if @game.laser != nil
			@game.laser.draw()
		end
	end

end #GameWindow

class Game

	attr_accessor :invaders
	attr_accessor :playerShip
	attr_accessor :laser
	
	def initialize(window)
		@window = window
	
		@invaders = Array.new
		@playerShip = PlayerShip.new( 218 , 600 , @window )
		@laser = nil
		
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
		if laser != nil
			i = 0
			for invader in @invaders
					if ( (@laser.x - invader.x)**2 + (@laser.y - invader.y)**2)**0.5 <= 50
						@invaders[i] = nil
						@laser = nil
					end
				i = i + 1
				@invaders.compact!
			end
		end
	end
	
	def moveObjects
		@invaders.each { |invader| invader.x += invader.velocity * $invaderSpeed }
		@playerShip.x += playerShip.velocity * $playerSpeed
		if @laser != nil
			@laser.y -= @laser.velocity * $laserSpeed
		end
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
		if @laser != nil
			if @laser.y <= 0
				@laser = nil
			end
		end
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
		@window.game.laser = (Laser.new( @x + 18 , @y , @window ))
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
	
	attr_accessor :x
	attr_accessor :y

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