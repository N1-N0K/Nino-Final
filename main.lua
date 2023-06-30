require 'src/Dependencies'

local background_scroll = 0

function love.load()

    if arg[#arg] == '-debug' then require('mobdebug').start() end

    io.stdout:setvbuf("no")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle("Catch the stars!")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {

        vsync = true,
        fullscreen = false, 
        resizable = true

    })

    math.randomseed(os.time())

    stateMachine = StateMachine {
		['start-menu'] = function() return StartMenuState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        --['pause'] = function() return PauseState() end,
      -- ['win'] = function() return WinState() end, 
        --['lose'] = function() return LoseState()end,
        --['skin'] = function() return SkinState()end
        --['highscores'] = function() return HighScoresState() end,
	}

    stateMachine:change('start-menu')


    fonts = {
        ['big'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['mid'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8)

    }

    textures = {
        ['background'] = love.graphics.newImage('graphics/starrysky.png'),
        ['yellowstar'] = love.graphics.newImage('graphics/star.png'),
        ['rainbowstar'] = love.graphics.newImage('graphics/rainbowstar.png'),
        ['bricks'] = love.graphics.newImage('graphics/bricks.png'),
        ['rocket'] = love.graphics.newImage('graphics/rockets.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png')
    }

    quads = {
        ['bricks'] = GenerateQuads(textures['bricks'], 32, 16),
        ['player'] = GenerateQuads(textures['rocket'], 79, 90),
        ['hearts'] = GenerateQuads(textures['hearts'], 16, 16)
    }

   

    sounds = {}

    love.keyboard.keysPressed = {}


end


function love.update(dt)
    background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % LOOPING_POINT
  
    stateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.resize(width, height)
	push:resize(width, height)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:start()

    love.graphics.draw(textures['background'], 0, -background_scroll)

    stateMachine:render()

    displayFPS()

    push:finish()
end

function displayFPS()
    love.graphics.setFont(fonts['small'])
    love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end