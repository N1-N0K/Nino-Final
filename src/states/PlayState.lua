PlayState = Class {__includes = BaseState}

function PlayState:enter(params)
    self.player = Player()
    self.bricks = params.bricks or {}
    self.health = params.health
    self.score = 0
    self.highscores = params.highscores or {}
    self.star = params.star or {}
    self.rainbowstar =  params.rainbowstar or {}

    self.timer = 0
    self.bricktimer = 0

    self.paused = false

    self.chance = math.random(1, 100)
end

function PlayState:update(dt)
  print(self.chance)
    if self.paused then 
        if love.keyboard.wasPressed('space') then
            self.paused = false
        else 
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        return
    end

    -- Update timers
    self.timer = self.timer + dt
    self.bricktimer = self.bricktimer + dt

    -- Insert objects into tables
    if self.bricktimer >= 3 then
        table.insert(self.bricks, Brick())
        self.bricktimer = 0 
    end

    if self.chance % 5 == 0 and self.timer >= 4 then
        table.insert(self.rainbowstar, Rainbowstar())
        self.chance = math.random(1, 100)
        self.timer = 0 
    elseif self.timer >= 4 then
        table.insert(self.star, Star())
        self.timer = 0
        self.chance = math.random(1, 100)
    end

    -- Update objects
    for k, star in pairs(self.star) do
        if not star.remove then
            star:update(dt)
        end
    end
        
    for k, rainbowstar in pairs(self.rainbowstar) do
        if not rainbowstar.remove then
            rainbowstar:update(dt)
        end
    end
        
    for k, brick in pairs(self.bricks) do
        if not brick.remove then
            brick:update(dt)
        end
    end

    self.player:update(dt)

    -- Handle object collisions
    for k, star in pairs(self.star) do
        if star:hit(self.player) then
            self.score = self.score + 1
            star.remove = true
            sounds['star']:play()
        end
    end


    for k, rainbowstar in pairs(self.rainbowstar) do
        if rainbowstar:hit(self.player) then
            self.score = self.score + 999
            sounds['win']:play()
            stateMachine:change('win', {
                score = self.score,
                highscores = self.highscores
            })
        end
    end

    for k, brick in pairs(self.bricks) do
        if brick:hit(self.player) then
            self.health = self.health - 1
            sounds['brickhit']:play()
            table.remove(self.bricks, k)
        end
    end

    --if object goes beyond screen

    for k, star in pairs(self.star) do
        if star.remove == true then
            table.remove(self.star, k)
        end
    end

    for k, rainbowstar in pairs(self.rainbowstar) do
        if rainbowstar.remove == true then
            table.remove(self.rainbowstar, k)
        end
    end


    for k, brick in pairs(self.bricks) do 
        if brick.remove == true then
            table.remove(self.bricks, k)
        end
    end

    -- Check for game over
    if self.health <= 0 then
        sounds['lose']:play()
        stateMachine:change('lose', {
            highscores = self.highscores,
            score = self.score
        })
    end
    
    -- Quit game
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- Render objects
    for k, rainbowstar in pairs(self.rainbowstar) do
        rainbowstar:render()
    end

    for k, star in pairs(self.star) do
        star:render()
    end

    for k, brick in pairs(self.bricks) do 
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    self.player:render()

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.setFont(fonts['small'])
    love.graphics.printf('Press space to pause the game.', 0, VIRTUAL_HEIGHT / 4 - 100, VIRTUAL_WIDTH, 'center')
end