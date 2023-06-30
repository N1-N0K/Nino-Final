ServeState = class {__includes = BaseState}


function ServeState:init(params)

   self.health = params.health
   self.player = params.player
   self.highscores = params.highscores
   self.score = params.score

end

function ServeState:update(dt)
    if love.keyboard.keypressed('enter') or love.keyboard.render('return') then
        StateMachine:change('play', {
            player = self.player,
            health = self.health,
            score = self.score,
            highscores = self.highscores
        })
    end
    
  
end

function ServeState:render()
    self.player:render()

    renderscore(self.score)
    renderHealth(self.health)

end