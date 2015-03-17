require_relative "BunnyInvadersClasses"

class GameWindow < Gosu::Window
	
	attr_accessor :game
	
	def initialize
		super(480, 640, false)
		self.caption = "Bunny Invaders"
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

$The_Game = GameWindow.new()
$The_Game.show()