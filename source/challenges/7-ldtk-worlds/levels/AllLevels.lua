-- Plains
--[[
    The plains are a vast expanse of land beyond the wall.

local plains = {
    -- monsters = { Monster:new("Undead Polarbear") },
    -- magnificent seven
    -- heros = HeroModel:createParty(magnificentSeven),
    guards = HeroModel:createParty({"unnamed guard 1", "unnamed guard 2", "unnamed guard 3"}) ,
}
-- Woods before Arrow Mountain
--[[
    The woods are a light forest beyond the wall that the party travels through to reach Arrow Mountain.

local woods = {
    monsters = {
        "Wight", "White Walker"
    },
    heroes = magnificentSeven,
}

-- Arrow Mountain

-- The Frozen Lake
--[[
    The Frozen Lake is a lake beyond the wall. 
    It is the location of the battle between the White Walkers and the Night's Watch.
    The Night King kills Viserion and turns him into a wight.
    Jon Snow and his party are rescued by Daenerys Targaryen and her dragons.

local frozenLakeCast = {
    monsters = {
        wights = Monster:createHorde("Wight", 1000),
        whiteWalkers = Monster:createHorde("White Walker", 100),
        nightKing = Monster:new("Night King"),
    },
    heros = {},
}
]]