# Modding Tutorial

In progress. If you have specific questions, please reach out to `radnyx_games` on Discord, or email `me@radnyx (dot) games`.

## Exported folder structure

This is how mod data looks when playing the game.

The `mods/` folder lives next to the Lil Guys executable. The game loads each folder inside `mods/` as its own mod.
For example, `base/` is a mod shipped with the game that defines the base game mode. You can add your own mod at `mods/my_mod_name/`, and it must have the following structure:

```
lilguys.exe
data_LilGuys_windows_x86_64/
mods/
|- base/
| |- ...
|- my_mod_name/
| |- assets.zip
| |- config/
| |  |- behaviors/
| |  |- plans/
| |  |- ...
| |  `- config.json
| |- demos/
| `- locales/
|- ...
```

Next, I'll cover how mod data is structured during development, and I'll explain how to test your mod in the game.

Finally, I'll explain how to publish a mod.

## Development folder structure

In order to develop and export your own mod, you need a lightweight Godot project. I recommend the following structure for mod development:

```
my_mod_name/
|- assets/
|- config/
|- demos/
`- locals/ 
docs/
project.godot
```

A couple things to notice:
- This is exactly how THIS repo is structured.
- While developing a mod, you need a folder named `assets/` (explained below). While playing, the game will expect a file named `assets.zip` instead (also explained below).

### assets/

Art, scripts, and Godot resources.

You can use these assets in configuration files by writing `"my_mod_name://path/to/file.xyz"`. 

For example, in the base mod's [config.json](../base/config/config.json), we use `"base://scripts/main.gd"` to load the script [assets/scripts/main.gd](../base/assets/scripts/main.gd). You can use assets from another mod by writing its name in the path instead.

The directory structure inside of `assets/` is up to you.

### config/

(todo, separately)

### demos/

(todo)

### locales/

Text and translations. Each file is a CSV whose name is a two letter language code. Taking [en.csv](../base/locales/en.csv) as an example:

```csv
castle_wall_name,Wall
castle_wall_description,Defensive structure
...
```

The first column is a unique key that identifies text used in your mod. The second column is the actual content of that text. Every locale file should contain the same keys and have text written in its respective language.

In this example, the key `castle_wall_description` is used in [buildings.json](../base/config/buildings.json):

```
{
    "castle_wall": {
        ...
        "name_text": "base:castle_wall_name",
        "description_text": "base:castle_wall_description",
        ...
    },
    ...
}
```

This sets the description text in the build menu for the `castle_wall` building.
Notice that the key is prefixed by `base:`. This is because it's using a localization key defined in the mod named `base`. You must specify which mod a key comes from.

## Testing a mod

(todo)

## Publishing a mod

(todo)