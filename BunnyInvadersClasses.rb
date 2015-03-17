#! usr/bin/env/ruby

require 'gosu'

$playerSpeed = 5
$invaderSpeed = 2
$laserSpeed = 10



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
			puts("You Win!")
			return true
		end
		return false
	end
	
	def defeat?
		if @invaders.last.y >= 600
			puts("GAME OVER")
			return true
		end
		return false
	end
	
	def checkCollisions
		if laser != nil
			for invader in @invaders
					if distanceBetween?(laser.x , laser.y , invader.x , invader.y) <= 50
						@invaders.delete(invader)
						@laser = nil
						$invaderSpeed = $invaderSpeed + 2 #to simulate the original game's "speeding up" after killing each invader
						break
					end
			end
		end
	end
	
	def distanceBetween?( x1 , y1 , x2 , y2 )
		return ((x1 - x2)**2 + (y1 - y2)**2)**0.5 #simple distance formula
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
		@xf = 0.22
		@yf = 0.22
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
		@structure = Gosu::Image.new( window , "space_invader.png" , false )
		@velocity = 1
		@xf = 0.225
		@yf = 0.225
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
		@structure = Gosu::Image.new( window , "circle.png" , false )
		@xf = 0.1
		@yf = 0.1
		@velocity = 1
	end
	
	def draw()
		super( @xf , @yf )
	end
	
end

######################################################################################

