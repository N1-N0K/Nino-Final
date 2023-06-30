PlayState = class {__includes = BaseState}

function PlayState:init(params)
    self.player = params.player
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highscores = params.highscores
    self.star = params.star --? 
    self.rainbowstar = paramas.rainbowstar
    
    self.paused = false

    self.timer = 0
    number = math.random(1,100)
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.paused then 
        if love.keyboard.wasPressed('space') then
            self.paused = false
        else 
            return  --?
        end
        
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        return
    end

    
    for k, star in pairs(self.obstacles) do
        if not star.remove then
            obstacle:update(dt)
        end

    end
        
    for k, rainbowstar in pairs(self.rainbowstar) do
        if not rainbowstar.remove then
            obstacle:update(dt)
        end
    end

        
    for k, bricks in pairs(self.bricks) do
        if not bricks.remove then
            bricks:update(dt)
        end
    end


    self.player:update(dt)

    
end

function PlayState:render()
    if number % 11 == 0 and self.timer == 2 then
        for k, star in pairs(self.rainbowstar) do
            rainbowstar:render()
        end
    else
        star:render()
    end

    
    for k, brick in pairs(self.bricks) do 
        brick:render()
    end


    renderScore(self.score)
	renderHealth(self.health)



    self.player:render()


    love.graphics.setFont(small_font)  
    --love.graphics.printf()  
end