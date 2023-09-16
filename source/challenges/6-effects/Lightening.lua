import "challenges/6-effects/libraries/AnimatedSprite"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Lightening').extends(AnimatedSprite)


--[[
AnimatedSprite has built in finite state machine

I want to be able to fire the lightening animation and once started, it should play through the 
animation and then return to idle
]]

local lighteningState = {
  isAnimating = false,
  hasPlayed = false,
}

local lightening = nil

local function onAnimationEndEvent()
  -- print("onAnimationEndEvent")
  lighteningState.isAnimating = false
  lighteningState.hasPlayed = true
  lightening:changeState("idle")
  print("strike has ended and is now idle: ",   lightening.currentState)
end

function Lightening:init(x, y)

  -- While the asset is named lightening-table-400-240.png we only need to pass the lightening part
  -- the rest tells the library how to slice the image into frames  
  local lighteningImageTable = gfx.imagetable.new("challenges/6-effects/assets/images/lightening")

  local animate = false; -- don't animate on init

  Lightening.super.init(self, lighteningImageTable, nil, animate)
  lightening = self

  self:addState("idle", 0, 0)
  -- set params loop to false
  self:addState("strike", 1, 11, { loop = false, tickStep =  2, onAnimationEndEvent = onAnimationEndEvent})

  -- Sprite Properties
  self:moveTo(x, y)
  self:setZIndex(Z_INDEXES.Lightening)
  self:setTag(TAGS.Lightening)
end


function Lightening:update()
  if not lighteningState.hasPlayed then
    self:updateAnimation()
    self:handleState()
  end
end


function Lightening:idle()
  -- print("idle lightening")
end

function Lightening:strike()
  if not lighteningState.isAnimating and not lighteningState.hasPlayed then
    print("striking lightening")
    lighteningState.isAnimating = true
    self:changeToStrike()
  end
end

function Lightening:handleState()
  if self.currentState == "idle" then
    self:idle()
  elseif self.currentState == "strike" then
    self:strike()
  end
end

-- State transitions

function Lightening:changeToIdleState()
  self:changeState("idle")
end


function Lightening:changeToStrike()
  self:changeState("strike")
end