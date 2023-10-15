---@diagnostic disable: undefined-global

import "./challenges/1-hello/GameHello"
-- import "./challenges/4-hud/GameGrid"
-- import "./challenges/4-hud/GameHud"
-- import "./challenges/6-effects/GameEffects"
-- import "./challenges/7-ldtk-worlds/GameBeyond"

local pd <const> = playdate
local gfx <const> = pd.graphics

--[[
This is a series of playdate challenges.     
To run each challenge, simple change the currentChallenge variable 
to the challenge you want to run.   

If you see the error: pxinfo not found found 
in the console this means there is a bug
somewhere in your code - we basically have to 
comment out code until the game runs again to isolate
where the bug might be. 
]]

local currentChallenge = 1


-- 1. hello playdate
-- I'm making this up as go... is there a code golf ace that I'm missing here? can I do this in 1 line?

if currentChallenge == 1 then
    -- HelloPlaydate.isRunning = true;
    -- HelloPlaydate.myGameSetUp()
    local helloGameInstance = GameHello("Pattison")
    helloGameInstance:tableDump()
end

-- 3. grid
if currentChallenge == 3 then
    -- GameGrid()
end

-- 4. heads up display aka the hud
if currentChallenge == 4 then
    -- GameHud()
    print("hello hud")
end

-- 6. effects
-- can I create a lightening strike to occur at a certain point? can I make it rain? Play thunder a sound?

if currentChallenge == 6 then
    -- Effects()
end

-- 7. effects
-- let's build a game based on a game of thrones episode and learn how to use the LDtk editor 

if currentChallenge == 7 then
    -- Beyond()
end

if currentChallenge == 8 then
    print("It's working again!")
    --[[]
    If you see the error: pxinfo not found found 
    in the console this means there is a bug
    somewhere in your code - we basically have to 
    comment out code until the game runs again to isolate
    where the bug might be. 

    This is a helpful block to hit while commenting out code.
    Sometimes, you may need to comment out a whole file of code!
    Always make sure the source compiles before walking away.

    It sucks to sit down on a saturday morning and have to spend
    an hour debugging a game that you thought was working.
    ---]]
end

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    if currentChallenge == 1 then
      --  print("ok hello update")
       GameHello:update()
    elseif currentChallenge == 6 then
       -- Effects:update()
    elseif currentChallenge == 7 then
      --  Beyond:update()
    end
   
end


