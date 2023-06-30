Player = class {}


function Player:init()

    self.width = self.width
    self.height = self.height

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.height = VIRTUAL_HEIGHT/2 - 50 

    self.dx = 0 
    self.dy = -3

    self.skin = 1

end

function Player:update(dt)
    if love.keyboard.isdown('left') then
        self.dx = -SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.min(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Player:render()
     love.graphics.draw(textures['rocket'], quads['player'][1])
end

function Player:skin()

end