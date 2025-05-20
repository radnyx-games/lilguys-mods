# Modding Tutorial

In progress. If you have specific questions, please reach out to `radnyx_games` on Discord, or email `me@radnyx (dot) games`.

## Folder structure

```
lilguys.exe
data_LilGuys_windows_x86_64/
mods/
|- my_mod_name/
| |- assets/
| |- config/
| |  |- behaviors/
| |  |- plans/
| |  |- ...
| |  `- config.json
| |- demos/
| `- locales/
|- ...
```

### assets/

Art, scripts, or any Godot files your mod depends on. 

You can access these in configuration files by writing `"mod_name://path/to/file.xyz"`. 

For example, in the base mod's [config.json](../config/config.json), we use `"base://scripts/main.gd"` to load the script [assets/scripts/main.gd](../assets/scripts/main.gd). You can use assets from another mod by writing its mod name instead.

The directory structure within assets/ is up to you.

### config/

(todo, in separate folders)

### demos/

(todo)

### locales/

Text and translations. Each file is a CSV whose name is a two letter language code. Taking [en.csv](../locales/en.csv) as an example:

```csv
castle_wall_name,Wall
castle_wall_description,Defensive structure
...
```

The first column is a unique key that identifies text used in your mod. The second column is the actual content of that text. Every locale file should contain the same keys and have text written in its respective language.

In this example, the key `castle_wall_description` is used in [buildings.json](../config/buildings.json):

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