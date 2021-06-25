# ALTTPR Item Editor

## System Requirements
BizHawk or Mesen S emulator

## Usage
Download the appropriate `item_editor.lua` script from the releases page.

In BizHawk or Mesen S, open the Lua Console and load `item_editor.lua`.

If there are no errors in the lua console, it should be working as expected.

While on the main playing screen or the item selection screen, press the L and R shoulder buttons<sup>1</sup> (as configured for your in-game SNES controller) simultaneously to open the item editting window.
If you were not already on the in-game item menu screen, it will open (to pause the game while you edit items).
This will show a list of items that can be set. To switch between pages of the menu, use the L and R shoulder buttons.
To move between items on a page, use Up and Down.
To edit an item, first press A then Left/Right to change values, and either A or B to confirm.
To exit the editor menu, simultaneously press the L and R shoulder buttons again.

While the editor menu is open, input will be swallowed by the lua script and will not affect the running game.


<sup>1</sup>This does conflict with quickswap if you have it enabled, but I don't have any better ideas. Feel free to suggest an alternative if you have an idea!
