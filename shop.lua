function love.load()
    love.window.setTitle("Orange Collecter")
    love.window.setMode(800, 600)

    local screen_width, screen_height = love.graphics.getDimensions()
    
    enmy_x = love.math.random(5, screen_width-5)   -- generate a "random" number for the x coord of this star
    enmy_y = love.math.random(5, screen_height-5)   -- both coords are limited to the screen size, minus 5 pixels of padding

    love.physics.setMeter(64)  -- 1 meter = 64 pixels
    world = love.physics.newWorld(0, 0, true)  -- No gravity (0,0)

    --Set Force
    setForce = 570

    -- Create player as a physics body
    player = {}
    player.body = love.physics.newBody(world, 400, 450, "dynamic")  -- Can move
    player.shape = love.physics.newCircleShape(20)  -- Circle with radius 20
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.fixture:setUserData("Player")
    player.body:setLinearDamping(5)  -- Slow down when no keys are pressed
    
    -- Collision detection
    world:setCallbacks(beginContact)

   end

function love.update(dt)
    world:update(dt)  -- Update physics world

    local force = setForce  -- Acceleration force

    if love.keyboard.isDown("d") then
        player.body:applyForce(force, 0)  -- Move right
    elseif love.keyboard.isDown("a") then
        player.body:applyForce(-force, 0)  -- Move left
    end
end

function love.draw()
    -- Set text color to white
    love.graphics.setColor(1, 1, 1)

    -- Print FPS just below it
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 50)

    --gets player pos
    local playerX, playerY = player.body:getX(), player.body:getY()

    -- Print the player position on the screen
    love.graphics.print("Player Position: X = " .. math.floor(playerX) .. ", Y = " .. math.floor(playerY), 10, 10)


    --Gets and prints velocity
    local vx, vy = player.body:getLinearVelocity()

    love.graphics.print("Velocity: " .. math.floor(vx) .. ", " .. math.floor(vy), 10, 30)

    -- Draw player (White)
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", player.body:getX(), player.body:getY(), player.shape:getRadius())

    --Set color to red for enemy 
    love.graphics.setColor(1, 0, 0, 1)

    --Draw red enemy randomly
    love.graphics.circle("fill", enmy_x, enmy_y, 25)

    --Reset Color for other shit idk
    love.graphics.setColor(1, 1, 1, 1)
end


