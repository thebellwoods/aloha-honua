import "challenges/7-ldtk-worlds/actors/ActorModel"

-- Define the Monster class and inherit from ActorModel
class('HeroModel').extends('ActorModel')

function HeroModel:init(name, hp, attack, defense, speed, lvl, exp, gold, drop, status, weakness, resistance)
    HeroModel.super.init(self, name, hp, attack, defense, speed, lvl, exp, gold, drop, status, weakness, resistance)
    self.name = name
    self.hp = hp

end

function HeroModel:printName()
    print("HeroModel printName")
end

function HeroModel:createParty(heroDetails)
  local party = {}
  for i, heroDetail in ipairs(heroDetails) do
    local hero = HeroModel()
    for k, v in pairs(heroDetail) do
      print(k, v)
      hero[k] = v
    end
    party[i] = hero
  end
  return party
end

--[[
-- Create a group of goblins
local goblins = {}
for i = 1, 5 do
  goblins[i] = Monster:new('Goblin', 10, 5)
end

-- Print the name, health, and damage of each goblin
for i, goblin in ipairs(goblins) do
  print('Goblin ' .. i .. ': ' .. goblin.name .. ', ' .. goblin.health .. ' health, ' .. goblin.damage .. ' damage')
end
]]