Rainbowstar = class {}

function Rainbowstar:init()
    self.image = textures['rainbowstar']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = math.random(self.width, VIRTUAL_WIDTH - self.width)
    self.y = 0

    self.dy = 3

    self.removed = false
    self.timer = 0

end

function Rainbowstar:update()
    self.dy = self.dy + SPEED * dt
    self.y = self.y + self.dy
end

function Rainbowstar:render()
    if not self.remove then
        love.graphics.draw(self.image, self.x, self.y)
    end
end

function Rainbowstar:hit()

    if self.y + self.height >= player.y - player.height and 
    self.x + self.width <= player.x - player.width then
     self.hit = true
     self.removed = true
 end

    self.removed = true
    params.scored = params.scored + 999
    
end

