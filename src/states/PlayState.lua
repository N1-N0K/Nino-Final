PlayState = Class {__includes = BaseState}

function PlayState:enter(params)
    self.player = Player()
    self.bricks = params.bricks or {}
    self.health = params.health
    self.score = params.score
    self.highscores = params.highscores
    self.star = params.star or {}
    self.rainbowstar = params.rainbowstar or {}

    self.paused = false

    self.timer = 0
    self.timerbrick = 0
    self.chance = math.random(1, 100)
end

function PlayState:update(dt)
    print('playstate')
    self.timer = self.timer + dt
    self.timerbrick = self.timerbrick + dt

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

    --insert objects in table

    if self.timerbrick >= 2 then
        table.insert(self.bricks, Brick(x, y))
        self.timer = 0 
    end

    if self.timer >= 4 and self.chance % 11 == 0 then
        table.insert(self.rainbowstar, Rainbowstar(x, y))
        self.timer = 0 
    else 
        table.insert(self.star, Star(x, y))
        self.timer = 0
    end

    -- Updating objects
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

    -- Hitting objects
    for k, star in pairs(self.star) do
        if star.hit then
            self.score = self.score + 3
            table.remove(self.star, k)
            sounds['star']:play()
        end
    end

    for k, rainbowstar in pairs(self.rainbowstar) do
        if rainbowstar.hit then
            self.score = self.score + 999
            table.remove(self.rainbowstar, k)
            sounds['win']:play()
            stateMachine:change('win', {
                score = self.score,
                highscores = self.highscores
            })
        end
    end

    for k, brick in pairs(self.bricks) do
        if brick.hit then
            self.health = self.health - 1
            sounds['brickhit']:play()
            table.remove(self.bricks, k)
        end
    end

    if self.health == 0 then
        sounds['lose']:play()
        stateMachine:change('lose', {
            highscores = self.highscores,
            score = self.score
        })
    end
end

function PlayState:render()
    -- Rendering objects

    for k, rainbowstar in pairs(self.rainbowstar) do
        rainbowstar:render()
    end

    for k, star in pairs(self.star) do
        star:render()
    end
    

    for k, brick in pairs(self.bricks) do 
        if self.timerbrick then
            brick:render()
        end
    end

    renderScore(self.score)
    -- renderHealth(self.health)

    self.player:render()
end