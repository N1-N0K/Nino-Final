StartMenuState = Class{__includes = BaseState}

local selected = 1


function StartMenuState:enter(params)
	self.highscores = params.highscores
    self.skin = params.skin
    self.health = params.health
    self.score = params.score
end

function StartMenuState:update(dt)
    --play or highscores or skins
    if love.keyboard.wasPressed('down') then
        selected = (selected % 3) + 1
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if selected == 1 then
            sounds['select']:play()
            stateMachine:change('serve', {
                highscores = self.highScores,
                score = self.score,
                timer = self.timer,
                bricktimer = self.bricktimer
            })
        elseif selected == 2 then
            sounds['select']:play()
            stateMachine:change('highscores', {
               highscores = self.highscores,
               score = self.score
            })
        elseif selected == 3 then 
            sounds['select']:play()
            stateMachine:change('skin', {
             highscores = self.highscores,
             score = self.score,
             skin = self.skin
            })
        end

    end 

    if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end


function StartMenuState:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.setFont(fonts['big'])
    love.graphics.printf('Catch the stars!', 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(fonts['mid'])
    
    if selected == 1 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end

    love.graphics.printf('PLAY', 0, VIRTUAL_HEIGHT/2 + 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if selected == 2 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
   
    love.graphics.printf('HIGH SCORES', 0, VIRTUAL_HEIGHT/2 + 65, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if selected == 3 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end

    love.graphics.printf('SKINS', 0, VIRTUAL_HEIGHT/2 + 90, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end