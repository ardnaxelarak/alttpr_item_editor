# ALTTPR Item Editor

## System Requirements
BizHawk with core set to BSNES (developed on v2.4, but should work with newer versions)

## Configuration
Edit `config.lua`.
- `trigger_menu`: This is the main configuration that should be editted by users for now. It stores a lua table of lua tables, with each entry in the main table containing a table of strings to press simultaneously as one option to open the main editor menu. Default is:
``` lua
{
  {
    "X1 LeftShoulder",
    "X1 RightShoulder",
  },
  {
    "J1 B5",
    "J1 B6",
  },
}
```
  This means that pressing buttons `X1 LeftShoulder` and `X1 RightShoulder` (left and right shoulder buttons on an Xbox controller) at the same time will open the menu, and so will pressing buttons `J1 B5` and `J1 B6` (left and right shoulder buttons on my generic controller). Change these to be whatever is reasonable for your setup, with key/button names matching what Bizhawk shows in the controller keybind menu.
- `use_network`: If set to true, this will open a network socket on `localhost:2134`, listen for connections, and print data received to the console. This is still a work in progress for something, and unless you are trying to develop something using these capabilities, it should be left `false`.
- `track_items`: If set to true, this will print to the console any time a memory address storing item information changes. This is mainly for my own debugging purposes and should probably be left `false` outside of development purposes.


## Usage
In BizHawk, open the Lua Console and load the `item_editor.lua` script from this repository. Assuming there are no errors in the lua console, it should be working as expected. While playing, press the buttons configured to open the menu (default left and right shoulder buttons pressed simultaneously; see Configuration above). This will show a list of items that can be set. To switch between pages of the menu, use the buttons configured as L and R for the SNES emulation. To move between items on a page, use Up and Down as configured for the SNES. To edit an item, first press A then Left/Right to change values, and either A or B to confirm.
To exit the editor menu, press the same key/button-combination that opened the menu.

WARNING: The game will not pause while the editor is open, but all input will be swallowed and not passed to the game. This means it is probably wise to open the item selection menu or map before opening the editor menu.
