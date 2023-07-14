ServeState = Class {__includes = BaseState}


function ServeState:enter(params)
   self.highscores = params.highscores
   self.health = 3
   self.score = params.score or 0
   self.timer = params.timer
   self.bricktimer = params.timer
  
   
   self.bricks = params.bricks or {}
   self.star = params.star or {}
   self.rainbowstar = params.rainbowstar or {}
   self.player = Player()

end

function ServeState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('play', {
            player = self.player,
            health = self.health,
            score = self.score,
            highscores = self.highscores,
            bricks = self.bricks,
            star = self.star,
            rainbowstar = self.rainbowstar
        })
    end

    if love.keyboard.wasPressed('escape') then
        stateMachine:change('start-menu', {
            highscores = self.highscores,
            score = self.score
        })
    end
    
    self.player:update(dt)
  
end

function ServeState:render()
    self.player:render()
    love.graphics.setFont(fonts['mid'])
    love.graphics.printf('PRESS ENTER TO START THE GAME!', 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, 'center')

    renderScore(self.score)
    renderHealth(self.health)

end