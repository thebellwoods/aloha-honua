---@diagnostic disable: undefined-global
import "./challenges/1-hello-playdate/hello-playdate"
import "./challenges/6-effects/Effects"
import "./challenges/7-ldtk-worlds/Beyond"

local pd <const> = playdate
local gfx <const> = pd.graphics

--[[

hello! this is a series of playdate challenges.     
    
Assuming you are using the Nova editor like me, first click the ahola-moon project and add Playdate as a task

To run each challenge, simple comment and uncomment them out.    
]]

local currentChallenge = 7


-- 1. hello playdate
-- I'm making this up as go... is there a code golf ace that I'm missing here? can I do this in 1 line?

if currentChallenge == 1 then
    HelloPlaydate.isRunning = true;
    HelloPlaydate.myGameSetUp()
end

-- 6. effects
-- can I create a lightening strike to occur at a certain point? can I make it rain? Play thunder a sound?

if currentChallenge == 6 then
    Effects()
end

-- 7. effects
-- let's build a game based on a game of thrones episode and learn how to use the LDtk editor 

if currentChallenge == 7 then
    Beyond()
end


function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()

    -- Effects:update()
    if currentChallenge == 6 then
        Effects:update()
    elseif currentChallenge == 7 then
        Beyond:update()
    end
   
end