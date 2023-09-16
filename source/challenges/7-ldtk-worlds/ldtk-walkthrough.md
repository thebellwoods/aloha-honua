<img src="./ldtk/0-frozen-lake.png" width="800px" />

I have been studying a [Metroidvania](https://en.wikipedia.org/wiki/Metroidvania) style build for playdate focussing on how to design a level with the LDTK.

Instead of metroidvania though, I'm planning to develop a turn-based strategy game based with a top down board. So no gravity nor need for jumping.

With a top down board, I can setup the final scene where our magnificient seven are surrounded by the army of the dead. The player will have to move the characters around the board to fight off the wights and white walkers until help arrives.

I like the simplicity of the tileset in the [playdate-metroidvania github](https://github.com/colingourlay/playdate-metroidvania) and would like to use it as a starting point for my own level design. I may enhance it to include more tiles which better express the harsh wilderness of Westeros.

### Open LDTK - What do I do now?!

Let's begin by creating a new project. If you're were of fan of [Origin](https://richardgarriott.com/gaming/), you'll remember the first thing you had to do was create a character. In LDTK, the first thing you do is create a world.

In this case, I called the world "Beyond the Wall" and we want to use the [GridVania](https://ldtk.io/docs/general/world/) system of layout.

<img src="./ldtk/1-create-world.png" width="800px" />

### Create a new level

After creating the world, we can create a new level. This time I went with the default naming convention so that I don't need to each level.

<img src="./ldtk/2-gridvania-world.png" width="800px" />

### Create 2 Layers

Next, we need to create a couple layers for our levels. We can create IntGrid layer and a Entity layer.

The IntGrid layer will be used to store the tilemap data. The Entity layer will be used to store the characters and other objects in the game.

<img src="./ldtk/3-current-level.png" width="800px" />

We can review the project settings but I didn't change anything here.

<img src="./ldtk/4-project-settings.png" width="800px" />

I created the IntGrid layer first and then the Entity layer by clicking the plus button. It's nice to know that you can drag and drop the layers to reorder them. You can do this on other screens as well.

<img src="./ldtk/5-add-2-layers.png" width="800px" />

To configure our IntGrid, we need to link it to our tileset. We can do this by clicking the Select a Tileset besides the Auto-layer tileset section.

<img src="./ldtk/5-A-add-tileset.png" width="800px" />

Now, we can add an enum for our tileset by clicking the Add Tileset Enum button. Our tileset will define the boundaries of our world so let's call it a TileEnum and add a Wall value to it.

<img src="./ldtk/5-B-add-tile-enum.png" width="800px" />

With our new TileNum, we can now select the Project Tilesets and link our TileEnum to our tileset.

<img src="./ldtk/5-C-add-enum.png" width="800px" />

We can now assign certain tiles to be drawn based on the Auto layout rules.

Be warned. This is a tricky part.

I haven't fully grasped as how to achieve what I want yet. I've watched this video: [LDtk - Powerful 2D Level Editor from Dead Cells Creator](https://www.youtube.com/watch?v=iCIx42csAH0) which does demo how to use this feature.

I actually gave up on cheated on this part as you see below. You can skip ahead to the Cheat section.

<img src="./ldtk/5-D-Add-Walls.png" width="800px" />

You can click back and forth between the Auto-layer and the Tileset to set how the tiles are being drawn. Do this individually for each tile until you have mapped out the entire set.

<img src="./ldtk/5-E-Add-all-walls.png" width="800px" />

Alright?!

Let's leave the IntGrid layer for now and move on to the Entity layer which is much easier to understand.

<img src="./ldtk/5-default-tile-set.png" width="800px" />

### Add Entities

We can add entities by clicking the Add Entity button.

<img src="./ldtk/6-add-entities.png" width="800px" />

I added a several entities who I refer to as Actors including our hero, NPCs, monsters, abilities and items.

<img src="./ldtk/7-design-enttity.png" width="800px" />

With these generic entities in place, we can now add specific entity enums to each one.

<img src="./ldtk/8-enums-hero.png" width="800px" />

Let's create our hero first: Jon Snow.

<img src="./ldtk/8-add-monster-enums.png" width="800px" />

With our hero in place, we can now add the other characters and monsters.

<img src="./ldtk/9-add-hero-but-fail-on-snow.png" width="800px" />

Next, I want to add Jon Snow to the tile but when I tried to do that, he wouldn't stick to the level.

<img src="./ldtk/9-make-jon-snow.png" width="800px" />

I had to assign the Jon Snow value of the enum to the entity.

<img src="./ldtk/9-add-hero-enum-to-entity.png" width="800px" />

With the hero on the map, I wanted to draw the walls around him. I tried to use the Auto-layer but it didn't work. I tried to use the Tileset but it didn't work. I tried to use the IntGrid but it didn't work.

Obviously, I found this part frustrating.

<img src="./ldtk/9-fail-to-draw-walls.png" width="800px" />

After failing to draw this walls in project, I returned the origin world.ldtk file and copied the walls group from there.

<img src="./ldtk/10-assistn-question-select-tiles.png" width="800px" />

Fortunately, I was able to copy and paste the walls group from the origin world.ldtk file into my beyond-the-wall.ldtk file. Once I did that and saved, the walls worked exatly as they had in the origin world.ldtk file.

<img src="./ldtk/11-clicking-backandforth-video.png" width="800px" />

I need to spend more time learning how to work with the Auto-layering tileset but for now this accomplishes what I need to build the walls and provides collision detection.

### Cheat - Copy & Paste

<img src="./ldtk/12-cheating-copy-paste-group-watch-autotile.png" width="800px" />

You can either cut or copy the group from one project and paste it into another. LDTK does shipped with several examples projects and following this technique if helpful for rapid prototyping.

<img src="./ldtk/12-paste-group-and-save.png" width="800px" />

After copying the walls group from the origin world.ldtk file into my beyond-the-wall.ldtk file, it didn't exactly work at first until I saved. When I save, you can visit the group rules and you should be able to hilight either the walls or the open spaces to see how the Auto-layering is working.

<img src="./ldtk/12-layer-rules" width="800px" />

Click on the Rules button next to the layers.

<img src="./ldtk/12-layer-rules-walls" width="800px" />

You can click on Walls or Background to highlight the tiles that are being drawn and you can see how the Walls have different rules than the background which is open space allowing the player to move around.

<img src="./ldtk/13-mac-dont-duplicate.png" width="800px" />

The last feature I want to try was to create a new level by copying my freshly created level. This might be a Mac bug because I copy the level but not reposition it. This isn't a big deal since the levels I'm creating as easy to recreate and it's actually fun to paint them individually!

### Test in the Playdate Simulator - Rinse & Repeat

Each time you save this project in LDTK, it will automatically update the project in the Playdate Simulator. You can see the results of your work by clicking the Play button.
