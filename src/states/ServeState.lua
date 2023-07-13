ServeState = Class {__includes = BaseState}


function ServeState:enter(params)

   self.highscores = params.highscores
   self.health = params.health
   self.score = params.score
   self.bricks = params.bricks
   self.star = params.star
   self.rainbowstar = params.rainbowstar

   self.player = Player()

end

function ServeState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        StateMachine:change('play', {
            player = self.player,
            health = self.health,
            score = self.score,
            highscores = self.highscores,
            bricks = self.bricks,
            star = self.star,
            rainbowstar = self.rainbowstar
        })
    end

    if love.keyboard.wasPressed('q') then
        stateMachine:change('start-menu', {
            highscores = self.highscores
        })
    end
    
    self.player:update(dt)
  
end

function ServeState:render()
    self.player:render()

    renderScore(self.score)
    --renderHealth(self.health)

end