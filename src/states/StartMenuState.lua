StartMenuState = class{__includes = BaseState}

local selected = 1

function StartMenuState:update(dt)
    print('menu')
    --play or highscores
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        selected = selected == 1 and 2 or 1 and 3 or 1 or 2 
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if selected == 1 then
            stateMachine:change('serve', {
                highscores = self.highScores
            })
        --elseif selected == 2
          --  stateMachine:change('highscores', {
            --    highscores = self.highscores
            --})
        --elseif selected == 3 then stateMachine:change('skin', {
            -- highscores = self.highscores
        --})
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