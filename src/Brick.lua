Brick = Class{}

function Brick:init()
    self.width = 32
    self.height = 16

    self.x = math.random(0, VIRTUAL_WIDTH - self.width)
    self.y = 0

    self.dy = 3

    self.remove = false
end

function Brick:update(dt)

    self.y = self.y + SPEED * dt

    if self.y + self.height  > VIRTUAL_HEIGHT then 
        self.remove = true
    end
end


function Brick:hit(player)
    if self.x + self.width < player.x or self.x > player.x + player.width then
        return false
    elseif self.y + self.height < player.y or self.y > player.y + player.height then
        return false
    else
        return true
    end
end

function Brick:render()
    love.graphics.draw(textures['bricks'], quads['bricks'][1], self.x, self.y)
end
