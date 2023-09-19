


class ('ActorModel').extends()

function ActorModel:init(name, hp, attack, defense, speed, lvl, exp, gold, drop, status, weakness, resistance)
    self.name = name
    self.hp = hp
    self.attack = attack
    self.defense = defense
    self.speed = speed
    self.lvl = lvl
    self.exp = exp
    self.gold = gold
    self.drop = drop
    self.status = status
    self.weakness = weakness
    self.resistance = resistance
end

function ActorModel:printName()
    print("ActorModel name: ", self.name)
end

-- Playdate SDK for creating classes
-- https://sdk.play.date/2.0.3/Inside%20Playdate.html#basic-playdate-game


