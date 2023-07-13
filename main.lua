require 'src/Dependencies'

local background_scroll = 0

function love.load(params)

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
        ['skin'] = function() return SkinState()end,
        ['highscores'] = function() return HighscoreState() end,
        ['play'] = function() return PlayState() end,
        ['enterhighscores'] = function() return EnterHighscoreState() end,
        ['win'] = function() return WinState() end, 
        ['lose'] = function() return LoseState()end
        
	}

    stateMachine:change('start-menu', {
        highscores = params.highScores
    })


    fonts = {
        ['big'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['mid'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8)

    }

    textures = {
        ['background'] = love.graphics.newImage('graphics/starrysky-01.png'),
        ['yellowstar'] = love.graphics.newImage('graphics/star.png'),
        ['rainbowstar'] = love.graphics.newImage('graphics/rainbowstar.png'),
        ['bricks'] = love.graphics.newImage('graphics/bricks.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png')
    }
    

    quads = {
        ['bricks'] = GenerateQuads(textures['bricks'], 32, 16),
        ['hearts'] = GenerateQuads(textures['hearts'], 16, 16)
    }

    skins = {
        ['rocket1'] = love.graphics.newImage('graphics/rocket.png'),
        ['rocket2'] = love.graphics.newImage('graphics/rockets2.png'),
        ['rocket3'] = love.graphics.newImage('graphics/rockets3.png'),
        ['rocket4'] = love.graphics.newImage('graphics/rockets4.png')

    }

   

    sounds = {
        ['select'] = love.audio.newSource('sounds/arkanoid6_sounds_select.wav', 'static'),
        ['lose'] = love.audio.newSource('sounds/lose.mp3', 'static'),
        ['star'] = love.audio.newSource('sounds/star.wav', 'static'),
        ['brickhit'] = love.audio.newSource('sounds/brickhit.wav', 'static'),
        ['win'] = love.audio.newSource('sounds/win.wav', 'static')
    }

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

--[[function renderHealth(health)
	local healthX = 20
	
	for i = 1, health do
		love.graphics.draw(textures['hearts'], quads['hearts'][8], healthX, 5)
		healthX = healthX + 12
	end
	
	for i = 1, 3 - health do
		love.graphics.draw(textures['hearts'], quads['hearts'][1], healthX, 5)
		healthX = healthX + 12
	end
end--]]


function love.draw()
    push:start()

    love.graphics.draw(textures['background'], 0, - background_scroll)

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


function renderScore(score)
	love.graphics.setFont(fonts['mid'])
	love.graphics.print('Score: ', VIRTUAL_WIDTH - 100, 5)
	love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end


function loadHighscores()
	love.filesystem.setIdentity('catchthestars')
	
	if not love.filesystem.getInfo('catchthestars.lst') then
		local scores = ''
		for index = 10, 1, -1 do
			scores = scores .. 'NAM\n'
			scores = scores .. 0 .. '\n'
		end
		
		love.filesystem.write('catchthestars.lst', scores)
	end
	
	local name = true
	local currentName = nil
	local counter = 1
	
	local scores = {}
	
	for index = 1, 10 do
		scores[index] = {
			name = nil,
			score = nil
		}
	end
	
	for line in love.filesystem.lines('catchthestars.lst') do
		if name then
			scores[counter].name = string.sub(line, 1, 3)
		else
			scores[counter].score = tonumber(line)
			counter = counter + 1
		end
		
		name = not name
	end
	
	return scores
end