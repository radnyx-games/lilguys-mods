## 0.0.4c - 2025-06-02

This update improves quality of life for players and modders. The biggest change is that Lil guys stay assigned to buildings when you command them. Holding Shift while commanding gives you more specific control, like overriding workers, assigning to full dispensers, or running away from enemies. 

Modders can enjoy writing GDScript to directly control entities. The whole concept of the King is defined in the configuration and script files. There are more helpful error messages, too.

And finally, the game runs way smoother. Much of the graphics lag has been vanquished, so the game should run a bit better on older machines.

### Features

- Lil guys stay assigned to buildings if manually assigned.
- Hold Shift during walk command to unassign lil guys from current job.
- Hold Shift to select multiple guys.
- Shift + Right Click a building to cancel assigned workers.
- Assigning to buildings only fills available slots. Hold Shift to override workers.
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
