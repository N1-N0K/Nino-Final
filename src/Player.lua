Player = Class {}


function Player:init()
    
    self.skin = skin
    self.width = self.skin:getWidth()
    self.height = self.skin:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT/2 + 75

    self.dx = 0

end

function Player:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -ROCKET_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = ROCKET_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Player:render()
     love.graphics.draw(self.skin, self.x, self.y)
end