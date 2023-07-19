LoseState = Class{__includes = BaseState}

function LoseState:enter(params)
    self.highscores = params.highscores
    self.score = params.score or 0
end

function LoseState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local highscore = false
        local scoreIndex = 0
        
        for index = 10, 1, -1 do
            local score = self.highscores[index] or 0
            if self.score > score then
                scoreIndex = index
                highscore = true
            end
        end
        
        if highscore then
            stateMachine:change('enter-highscore', {
                highscores = self.highscores,
                score = self.score,
                scoreIndex = scoreIndex
            })
        else
            stateMachine:change('start', {
                highscores = self.highscores
            })
        end
        
    end
end

function LoseState:render()
    love.graphics.setFont(fonts['big'])
    love.graphics.printf('GAME OVER!', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(fonts['mid'])
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
end