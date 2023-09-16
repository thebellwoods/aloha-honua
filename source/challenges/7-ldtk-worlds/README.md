# LDTK Worlds

This is a study of the [LDTK editor](https://ldtk.io/) that is used in the [playdate-metroidvania](https://github.com/colingourlay/playdate-metroidvania) project.

My challenge is to build a small world inspired by Game of Thrones episode where they are [surrounded by White Walkers](https://www.inverse.com/article/35630-game-of-thrones-season-7-jon-snow-white-walker-night-king-defeat-zombies-die) on the frozen lake.

- [the stand](https://www.youtube.com/watch?v=ecoUbauemEA)
- [the escape](https://www.youtube.com/watch?v=WILTYa-fJms)
- [magnificent 7](https://www.perplexity.ai/search/9f9202ca-d842-4198-9c30-782a3425fc53?s=c)
- [Episode: Beyond the Wall](<https://gameofthrones.fandom.com/wiki/Beyond_the_Wall_(episode)>)
- [General: Beyond the Wall](https://gameofthrones.fandom.com/wiki/Beyond_the_Wall)

I've taken the notes from the LDTK.lua file and organized them here into steps to follow.

## Steps

1. plan the world - it was fun to re-visit this episode and study it in detail. While I remembered the overall story arc, I realized I had forgotten so many of the facts like who joined Jon on the hunt for the wight and even how many dragons appeared at the end? Which one did the Night King slay? I even forgot about the blue eyed polar bear!

LDtk has an option to save each level in seperate files.

That allows you to load and unload levels when you need it instead of having the whole world in memory.

```
LDtk.load_level( "Level_1" )
LDtk.release_level( "Level_0" )
```

LDtk has an option to save each level in seperate files.

That allows you to load and unload levels when you need it instead of having the whole world in memory.

```
LDtk.load_level( "Level_1" )
LDtk.release_level( "Level_0" )
```

Note: release_level() is freeing the tileset so it is better to release a level after loading the next level if they use the same tilesets.

Parsing json can be long especially when running on the playdate to speed up loading there is an option to load directly lua files in the simulator call LDtk.export_to_lua_files() after a LDtl file is loaded to save the exported lua files in the save folder

copy the LDtk_lua_levels/ next to your .ldtk file in your project directory

2. Load the levels at the beginning of the game

```
LDtk.load( "levels/world.ldtk" )
tilemap = LDtk.create_tilemap( "Level_0" )
```

3. collision detection

To get collision information, in LDtk create an enum for tiles (Wall, Water, Ladder etc.)
Use the enum in the tileset and tag tiles with the desired property

```
playdate.graphics.sprite.addWallSprites( game.tilemap, LDtk.get_empty_tileIDs( "Level_0", "Solid") )
```

## Beyond the Wall LDTK Tutorial

1. Create a new project in LDtk. It's intimidating at first as there is no guide or hint on what to do.

Since I have been using the playdate-metroidvania project as a guide, I decided to create a new project in LDtk and use the same tileset as the playdate-metroidvania project.

I recommend watching:

- [LDtk - Powerful 2D Level Editor from Dead Cells Creator](https://www.youtube.com/watch?v=iCIx42csAH0)
- [Creating 2D Game Worlds In the Powerful (and Free!) LDtk](https://www.youtube.com/watch?v=ck8ohhC0XdM)
- [How to Make a Metroidvania/Platformer | Playdate SDK Tutorial](https://www.youtube.com/watch?v=7GbUxjE9rRM)
- [Tales of Yore LDTK Tutorial Series (Layers)](https://www.youtube.com/watch?v=Ndk2Yg8hoS4)

## JSON Workd Export

As LDTK can exports [the world as JSON](https://ldtk.io/docs/game-dev/json-overview/), I could then use this json file within the React common components library [cross-country](https://github.com/headwinds/cross-country)
