local pd <const> = playdate
local gfx <const> = playdate.graphics

import "challenges/7-levels/libraries/AnimatedSprite"
import "challenges/7-levels/actors/hero/HeroModel"

class('HeroSprite').extends(AnimatedSprite)

function HeroSprite:init(x, y, gameManager, model)
  self.gameManager = gameManager
  print (x, y)

  -- State Machine
  local playerImageTable = gfx.imagetable.new("challenges/7-levels/assets/images/player")

  HeroSprite.super.init(self, playerImageTable)

  self:addState("idle", 1, 1)
  self:addState("run", 1, 3, { tickStep =  4})
  self:playAnimation()

  -- Sprite Properties
  self:moveTo(x, y)
  self:setZIndex(Z_INDEXES.HeroSprite)
  self:setTag(TAGS.HeroSprite)
  self:setCollideRect(3, 3, 10, 13)

  -- Physics Properties
  self.xVelocity = 0
  self.yVelocity = 0
  self.maxSpeed = 2

  -- Dash
  self.dashAvailable = true
  self.dashSpeed = 8
  self.dashMinimumSpeed = 3
  self.dashDrag = 0.8

  -- HeroSprite State
  -- self.touchingGround = false
  -- self.touchingCeiling = false
  self.touchingWall = false
  self.dead = false

  self.model = model
end

function HeroSprite:collisionResponse(other)
  local tag = other:getTag()

  if tag == TAGS.Hazard or tag == TAGS.Pickup then
    return gfx.sprite.kCollisionTypeOverlap
  end

  return gfx.sprite.kCollisionTypeSlide
end

function HeroSprite:update()
  if self.dead then
    return
  end

  self:updateAnimation()
  self:handleState()
  
  self:handleMovementAndCollisions()
end

function HeroSprite:handleState()
  if self.currentState == "idle" then
    self:handleGroundInput()
  elseif self.currentState == "run" then -- does run makes in a turn based strat? probably not
    self:handleGroundInput()
  end

end

function HeroSprite:handleMovementAndCollisions()

  local _, _, collisions, length = self:moveWithCollisions(self.x + self.xVelocity, self.y + self.yVelocity)
  local died = false

  print("move")

  -- self.touchingGround = false
  -- self.touchingCeiling = false
  self.touchingWall = false

  for i=1,length do
    local collision = collisions[i]
    local collisionType = collision.type
    local collisionObject = collision.other
    local collisionTag = collisionObject:getTag()

    if collisionType == gfx.sprite.kCollisionTypeSlide then
      if collision.normal.y == -1 then
        -- self.touchingGround = true
      elseif collision.normal.y == 1 then
        -- self.touchingCeiling = true
      end

      if collision.normal.x ~= 0 then
        self.touchingWall = true
      end
    end

    if collisionTag == TAGS.Hazard then
      died = true
    elseif collisionTag == TAGS.Pickup then
      collisionObject:pickUp(self)
    end
  end

  if self.xVelocity < 0 then
    self.globalFlip = 1
  elseif self.xVelocity > 0 then
    self.globalFlip = 0
  end

  if self.x < 0 then
    self.gameManager:enterRoom("west")
  elseif self.x > 400 then
    self.gameManager:enterRoom("east")
  elseif self.y < 0 then
    self.gameManager:enterRoom("north")
  elseif self.y > 240 then
    self.gameManager:enterRoom("south")
  end

  if died then
    self:die()
  end
end

function HeroSprite:die()
  self.xVelocity = 0
  self.yVelocity = 0
  self.dead = true
  self:setCollisionsEnabled(false)

  pd.timer.performAfterDelay(200, function ()
    self:setCollisionsEnabled(true)
    self.gameManager:resetHeroSprite()
    self.dead = false
  end)
end

-- Input Helper Functions

function HeroSprite:handleGroundInput()
  if pd.buttonIsPressed(pd.kButtonLeft) then
    self:changeToRunState("left")
  elseif pd.buttonIsPressed(pd.kButtonRight) then
    self:changeToRunState("right")
  elseif pd.buttonIsPressed(pd.kButtonUp) then
      self:changeToRunState("up")
  elseif pd.buttonIsPressed(pd.kButtonDown) then
      self:changeToRunState("down")
  else
    self:changeToIdleState()
  end
end

-- State transitions

function HeroSprite:changeToIdleState()
  self.xVelocity = 0
  self.yVelocity = 0
  self:changeState("idle")
end

function HeroSprite:changeToRunState(direction)
  if direction == "left" then
    self.xVelocity = -self.maxSpeed
    self.globalFlip = 1
  elseif direction == "right" then
    self.xVelocity = self.maxSpeed
    self.globalFlip = 0
  elseif direction == "up" then
    self.yVelocity = -self.maxSpeed
    self.globalFlip = 0
  elseif direction == "down" then
    self.yVelocity = self.maxSpeed
    self.globalFlip = 1
  end

  self:changeState("run")
end