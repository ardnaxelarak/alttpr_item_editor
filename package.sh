COMMAND=luacc
if [[ "$OSTYPE" == "msys" ]]; then
  COMMAND=luacc.bat
fi

$COMMAND -o release/bizhawk/item_editor.lua bizhawk.item_editor bizhawk.gfx bizhawk.mem bizhawk.controller items menu_drawer
$COMMAND -o release/mesen/item_editor.lua mesen.item_editor mesen.bit_wrapper mesen.graphics mesen.memory mesen.controller items menu_drawer
