SkinState = Class {__includes = BaseState}

chooseskin = 1

function SkinState:enter(params)
    self.skin = params.skin
    self.highscores = params.highscores
end

function SkinState:update(dt)

    if love.keyboard.wasPressed('down') then
        chooseskin = (chooseskin % 4) + 1
    end
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') and chooseskin == 1 then
        sounds['select']:play()
        self.skin = skins['rocket1']
        print('skin chosen')
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') and chooseskin == 2 then
        sounds['select']:play()
        self.skin = skins['rocket2']
         print('skin chosen')
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') and  chooseskin == 3 then
        sounds['select']:play()
        self.skin = skins['rocket3']
         print('skin chosen')
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') and  chooseskin == 4 then
        sounds['select']:play()
        self.skin = skins['rocket4']
         print('skin chosen')
    end

    if love.keyboard.wasPressed('q') then
        stateMachine:change('start-menu', {
            highscores = self.highscores,
            skin = self.skin
        })
    end

end


function SkinState:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.setFont(fonts['big'])
    love.graphics.printf('Choose the skin', 0, VIRTUAL_HEIGHT/6, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(fonts['mid'])
    
    if chooseskin == 1 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end

    love.graphics.printf('Orange rocket', 0, VIRTUAL_HEIGHT/2 + 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if chooseskin == 2 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
   
    love.graphics.printf('Pink rocket', 0, VIRTUAL_HEIGHT/2 + 65, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if chooseskin == 3 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end

    love.graphics.printf('Blue rocket', 0, VIRTUAL_HEIGHT/2 + 90, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    if chooseskin == 4 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end

    love.graphics.printf('Purple rocket', 0, VIRTUAL_HEIGHT/2 + 115, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end