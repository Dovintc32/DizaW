local Cube = {
    x = 100,
    y = 100,
    width = 64,
    Speed = 200,
    vy = 0,
    On_ground = false
}   

local screenWidth, screenHeight = love.window.getDesktopDimensions()

local Buttons = {
    Start = {
        x = 300,
        y = 250,
        w = 200,
        h = 50
    }
}

local Game = {
    state = "Load",
    timerToPrompt = 10
}

local debug = {
    enabled = false
}

local Ground = {
    x = 0,
    y = 536,
    w = 800,
    h = 100
}

local fuction = require "fuction"

function love.load()
    robotSpriteUp = love.graphics.newImage("Image/Robot/RobotL1_Up.png")
    robotSpriteLeft = love.graphics.newImage("Image/Robot/RobotL1_Left.png")
    robotSpriteRight = love.graphics.newImage("Image/Robot/RobotL1_Right.png")
    robotSprite = robotSpriteUp
    fuction.ChangeFont(10)

    if Game.state == "Load" then
        love.window.setTitle("DizaW")
    end
end

function love.update(dt)
    if Game.state == "Load" then
        Game.timerToPrompt = Game.timerToPrompt - dt
    end

    if Game.state == "Play" then
        if love.keyboard.isDown("a") and Cube.x >= 0 then 
            Cube.x = Cube.x - Cube.Speed * dt
            robotSprite = robotSpriteLeft
        end
        if love.keyboard.isDown("d") then 
            Cube.x = Cube.x + Cube.Speed * dt
            robotSprite = robotSpriteRight
        end
        if love.keyboard.isDown("space") and Cube.On_ground then
            robotSprite = robotSpriteUp
            Cube.vy = -500
        end

        Cube.vy = Cube.vy + 800 * dt
        Cube.y = Cube.y + Cube.vy * dt

        if Cube.y + Cube.width > Ground.y then
            Cube.y = Ground.y - Cube.width
            Cube.vy = 0
            Cube.On_ground = true
        end
        if Cube.y + Cube.width < Ground.y then
            Cube.On_ground = false
        end
    end
end

function love.keypressed(key)
    if key == "f11" then
        if love.window.getFullscreen() then
            love.window.setMode(800, 600, {
                fullscreen = false,
                resizable = true,
                vsync = true
            })
        else
            local dw, dh = love.window.getDesktopDimensions()
            love.window.setMode(dw, dh, {
                fullscreen = true,
                vsync = true
            })
        end
    end

    if Game.state == "Load" then
        Game.state = "Play"
    end
    if Game.state == "Play" then
        if key == "f3" then
            debug.enabled = not debug.enabled
        end
    end
end

function love.draw()
    if Game.state == "Load" then
        love.graphics.setColor(0.5, 1, 0)
        fuction.ChangeFont(120)
        love.graphics.print(fuction.FindCenter("DizaW", 240))
        fuction.ChangeFont(25)
        love.graphics.setColor(0.5, 1, 1)
        love.graphics.print(fuction.FindCenter("Create By Dovintc", 350))    
    end
    if Game.state == "Load" and Game.timerToPrompt <= 0 then
        local pulse = (math.sin(love.timer.getTime() * 4) + 1) / 2
        love.graphics.setColor(1, 1, 1, pulse)
        fuction.ChangeFont(20)
        love.graphics.print(fuction.FindCenter("Press any key to play", 400))
        love.graphics.setColor(1, 1, 1, 1)
    end

    if Game.state == "Menu" then
        love.graphics.setColor(0.2, 0.6, 0.1)
        love.graphics.rectangle("fill", Buttons.Start.x, Buttons.Start.y, Buttons.Start.w, Buttons.Start.h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Start", Buttons.Start.x + 60, Buttons.Start.y + 15)
    end

    if Game.state == "Play" then
        fuction.ChangeFont(10, "Font/Digital Pixel V31/DigitalPixelV31-Regular_0.ttf")

        -- Квадрат
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(robotSprite, Cube.x, Cube.y)

            -- Земля 
        love.graphics.setColor(0, 0.7, 0)
        love.graphics.rectangle("fill", Ground.x, Ground.y, Ground.w, Ground.h)

        local windowWidth = love.graphics.getWidth()
        local windowHeight = love.graphics.getHeight()
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()
        Ground.y = h - 64
        Ground.w = w

            -- Debug информация
        if debug.enabled then

            love.graphics.setColor(1, 1, 1)
            local major, minor, revision = love.getVersion(true)
            local info = {
                "Ver. Love2D: " .. major .. "." .. minor .. "." .. revision,
                "Ver. DizaW: " .. "0.1.4",
                "FPS: " .. love.timer.getFPS(),
                "XY: " .. math.floor(Cube.x) .. " " .. math.floor(Cube.y),
                "VY (Velocity Y): " .. string.format("%.1f", Cube.vy),
                "On Ground: " .. tostring(Cube.On_ground),
                "XY cursor: " .. love.mouse.getX() .. " " .. love.mouse.getY(),
                "Size Monitor: " .. screenWidth .. "*" .. screenHeight,
                "Size Window: " .. w .. "*" .. h,
                "Ground: X" .. Ground.y .. ' Y' .. Ground.x .. " W" .. Ground.w .. " H" .. Ground.h
            }

            local y = 10
            for i, line in ipairs(info) do
                love.graphics.print(line, 10, y)
                y = y + 20
            end
        end
    end
end