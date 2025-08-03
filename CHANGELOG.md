## 0.0.5 - 2025-08-03

## 0.0.4e - 2025-07-30

Menu overhauls and blueprint improvements. This is all in preparation for cannons and item crafting.

### Features

- Warping to the King with 'K' selects him.
- Tile hover menu.
- Item hover menu.
- Enemy hover menu.
- Lil Guy menu, with editable random name.
- Outposts can filter by basic or fighter class.
- Building settings can be changed from the blueprint.
- Building settings can be copy and pasted.
- Buildings keep settings when destroyed by enemies.

### Modding

- Worker class is controlled by 'add_tag' and 'remove_tag' methods.

## 0.0.4d - 2025-06-29

Better selection controls, bug fixes, and bug report button.

### Features

- Click on enemies to send lil guys to attack.
- Hover over items to show who's coming to pick it up.
- Better visual feedback when selecting entities.
- Bug report button to easily export world with a screenshot.

### Fixes

- Knights poorly spacing attacks.
- Knights not seeing enemies through doors.
- Many other door bugs.

### Modding

- Added "on_dibs" script event when a worker is assigned a job.
- Removed "effects" list in items config in favor of script events.

## 0.0.4c - 2025-06-19

This update improves the quality of life for players and modders. The biggest change is that lil guys stay assigned to buildings if you command them. Holding Shift while commanding gives you fine-grained control, like overriding workers, assigning to full dispensers, and running away from combat. 

Modders can now use GDScript to directly control entities and the overall game mode. For example, the King is entirely defined in the script and config files. There are more helpful error messages, too.

And finally, the game runs way smoother. Much of the graphics lag is vanquished, so the game should run better on older machines.

### Features

- Lil guys stay assigned to buildings if manually assigned.
- Hold Shift during walk command to unassign lil guys from current job.
- Hold Shift to add lil guys to the current selection.
- Shift + Right Click a building to cancel assigned workers.
- Assigning to buildings only fills available slots. Hold Shift to override workers.
- Outpost guards can see enemies through doors.
- F12 to take screenshot.
- Added VSync and borderless window graphics options.
- Greatly reduced graphics lag and mining lag.
- Improved save time by 60%.
- Improved load time by 30%.
- Lil guys react faster after getting hit.
- Raised destruction limit to 2000.

### Fixes

- Lil guys getting distracted from outposts.
- Possible to game over on title screen.
- Lil guys dropping items through walls.
- Removed ability to destroy blocks outside play zone.

### Modding

- Visible error messages.
- Base game mode and king are entirely moddable.
- Lil guys can have specialized jobs.
- Added knight lil guys in the creative menu.

## 0.0.4b - 2024-11-25

- raised Door cost to 8 rocks
- fixed: thousands of Doors breaking pathfinding
- fixed: proportion of Skullos to Shelltanks in later waves

## 0.0.4 - 2024-11-25

This is an important one! Since the gameplay was fleshed out in 0.0.3, this update 
expands on it by added 2 new buildings and 1 new enemy. This opens up new
challenges, new defense strategies, and new ways to decorate your kingdom.

Special thanks to those who playtested the preview and caught bugs before release.

### Fun stats
- 296 separate patches
- 24,294 lines of code added
- 12,652 lines of code removed
- demo currently has 4,844 total downloads

## 0.0.4preview4 - 2024-11-24

- fixed lil guys stuck running in place
- fixed bug when sending bakery commands after reaching lil guy limit
- reduced game size by 10 MB
- re-enabled OpenGL support for older hardware

## 0.0.4preview3 - 2024-11-18

- fixed blank settings in options menu
- reduced game size by 50 MB

## 0.0.4preview2 - 2024-11-16

- fixed enemies getting stuck outside the world
- fixed edge case where lil guys stopped doing work
- fixed doors not dropping their blueprint cost
- fixed building shadows staying if destroyed while saving/loading
- you can now guard outposts behind 1 layer thick walls
- you can now read `game.log` next to the executable if the game crashes
- clarified controls hints on bottom left
- made it easier to click outposts surrounded by lil guys

## 0.0.4preview - 2024-11-15

- new building: Door
- new building: Outpost
- new enemy: Shelltank
- new item: Bomb
- much faster physics engine
- lil guys avoid clumping
- spawn anything by pressing F4
- improved controls, added customization menu
- cut savefile size by 40%
- fixed issues with lil guys not doing work
- removed ohio

## 0.0.3f - 2024-07-19

- graphical fixes and improvements
- improved FPS when many lil guys are walking
- fixed `world_size` in config.json to allow any size

## 0.0.3e - 2024-07-15

- fix: destructions stuck when enemies break the tile
- improved windows launcher for Vulkan and OpenGL 3 users

## 0.0.3d - 2024-07-12

- raised lil guy limit to 150 :lilguy_king:
- added launcher for older windows machines

## 0.0.3c - 2024-07-11 

- GREATLY improved lag, especially when many lil guys are digging
- less chaotic digging patterns
- lil guys pick closest available item instead of approximating
- fix: lil guys only digging one side of a wall, instead of the closest side
- linux version!

## 0.0.3b - 2024-06-24

- fixed unable to destroy castle walls

## 0.0.3 - 2024-06-23

Thanks everyone for playing 0.0.2 and helping find issues. This update tackles the most common problems with the AI, and adds some new king related gameplay. It means a lot that you've taken this much interest in a still very early project.

### Fun stats
- 200 files updated
- 135 separate patches
- the last version 0.0.2 had 2588 downloads

### New gameplay
- King drops the crown when defeated. Don't let the enemies take it away! 

### Lil Guy and enemy AI
- lil guys target destruction jobs closest to king, instead of picking randomly
- lil guys are better at tunneling
- hover over a building to see its workers
- lil guys take revenge on enemies who hurt them (prevents beelining through crowds) 
- limit on how many lil guys can attack an enemy, based on enemy health remaining
- enemies will try attacking player buildings instead of tunneling
- commanding the king to walk overrides fleeing from enemies 

### Other improvements
- full screen in options menu
- floating crown icon to show where the king is and if in danger
- crown button (hotkey: K) to warp to King
- "MAX" icon to dispensers and lil guy counter
- better map generation, clear entry/exits for enemies

### Fixes
- lil guys sometimes not obeying manual commands
- lil guys losing HP after loading a save
- lil guys not filling up buildings
- enemies wandering backwards to old tunnels
- fog graphical glitches
- fixed skibidi toilet jumpscare
