
-- Window Parameters
    -- Local states that this variable is used only in this file
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600
local imageWidth
local imageHeight

-- MAIN FUNCTIONS
function love.load()
    -- Setup the window
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    love.window.setTitle("War and Deceit")
end

function love.update(dt)
end

function love.draw()
end

local cardImg

function love.load()
    cardImg = love.graphics.newImage("/Card Art/2_of_Hearts.png")
    imageWidth = cardImg:getWidth()
    imageHeight = cardImg:getHeight()
end

local xPos = (WINDOW_WIDTH - imageWidth) / 2
local yPos = (WINDOW_HEIGHT - imageHeight) / 2

function love.draw()
    love.graphics.draw(cardImg, xPos, yPos)
end
