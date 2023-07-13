Brick = Class{}

function Brick:init()
    self.width = 32
    self.height = 16

    self.x = math.random(0, VIRTUAL_WIDTH)
    self.y = 0

    self.dy = 3

    self.removed = false
    self.hit = false
end

function Brick:update(dt)
    self.dy = self.dy + SPEED * dt
    self.y = self.y + self.dy
end

function Brick:render()
    if self.removed == false then 
        love.graphics.draw(textures['bricks'], quads['bricks'][1])
    end
end

function Brick:hit(player)
    if self.y + self.height >= player.y - player.height and 
       self.x + self.width >= player.x - player.width then
        self.hit = true
        self.removed = true
    end
end