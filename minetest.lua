---@meta

-- We follow sections and order from lua_api.txt
-- except for table definitions and classes: we put those first and
-- sort them alphabetically.

-- Basic definitions
--------------------

---@alias minetest.ObjectId integer

---@alias minetest.NodeName string

---This is an implementation detail and should be treated as an opaque type
---TODO: use opaque type https://github.com/LuaLS/lua-language-server/issues/2074
---@alias minetest.ObjectHandle integer

-- Class and global tables
--------------------------

---@class minetest
---
---TODO verify whether all these are actually indexed by strings (or is there any difference?)
---@field registered_items {[minetest.NodeName]: minetest.ItemDef}
---@field registered_nodes {[minetest.NodeName]: minetest.NodeDef}
---@field registered_craftitems {[minetest.NodeName]: minetest.ItemDef}
---@field registered_tools {[minetest.NodeName]: minetest.ItemDef}
---@field registered_entities {[string]: minetest.EntityDef}
---@field object_refs {[minetest.ObjectId]: minetest.ObjectRef}
---@field luaentities {[minetest.ObjectId]: minetest.LuaEntity}
---@field registered_abms minetest.ABMDef[]
---@field registered_lbms minetest.LBMDef[]
---@field registered_aliases {[minetest.NodeName]: minetest.NodeName}
---@field registered_ores {[string | minetest.ObjectHandle]: minetest.OreDef}
---@field registered_biomes {[string | minetest.ObjectHandle]: minetest.BiomeDef}
---@field registered_decorations {[string | minetest.ObjectHandle]: minetest.DecorationDef}
---@field registered_schematics {[string | minetest.ObjectHandle]: minetest.SchematicDef}
---@field registered_chatcommands {[string]: minetest.ChatcommandDef}
---@field registered_privileges {[string]: minetest.PrivilegeDef}
---
---@field registered_globalsteps {[any]: fun(dtime : number)}
---@field registered_on_mods_loaded {[any]: fun()}
---TODO other registered global registration function tables
minetest = {}

-- Definition tables
--------------------

-- Sorted alphabetically

---@class minetest.ABMDef

---@class minetest.BiomeDef

---@class minetest.ChatcommandDef

---@class minetest.DecorationDef

---@class minetest.EntityDef

---@class minetest.ItemDef
---@field description string?
---@field short_description string?
---@field groups {[string]: number}?
---@field inventory_image string?
---@field inventory_overlay string?
---@field wield_image string?
---@field wield_overlay string?
---@field wield_scale vector.Vector?
---@field palette string?
---@field color string?
---@field stack_max integer?
---@field range number?
---@field liquids_pointable boolean?
---@field light_source integer?
---@field tool_capabilities any? # TODO
---@field node_placement_prediction string?
---@field node_dig_prediction string?
---@field sound minetest.ItemSound?
---@field on_place any # TODO
---@field on_secondary_use any # TODO
---@field on_drop any # TODO
---@field on_pickup any # TODO
---@field on_use any # TODO
---@field after_use any # TODO

---@class minetest.ItemSound
---@field breaks? minetest.SimpleSoundSpec
---@field eat? minetest.SimpleSoundSpec
---@field punch_use? minetest.SimpleSoundSpec
---@field punch_use_air? minetest.SimpleSoundSpec

---@class minetest.LBMDef

---@class minetest.NodeDef

---@class minetest.OreDef

---@class minetest.PrivilegeDef
---@field description string?
---@field give_to_singleplayer boolean?
---@field give_to_admin boolean?
---@field on_grant fun(name : string, granter_name : string?)
---@field on_revoke fun(name : string, revoker_name : string?)

---@alias minetest.SchematicDef string | minetest.RawSchematicDef
---@class minetest.RawSchematicDef

---@class minetest.SimpleSoundSpec

-- * Extra definitions
----------------------

-- These are not actually in the doc, but we define them for convenience

---@alias minetest.Privs {[string]: boolean}

---@alias minetest.Node { name : string, param1 : integer, param2 : integer }
---@alias minetest.NodeOpt { name : string, param1? : integer, param2? : integer }

-- Classes
----------

-- Sorted alphabetically

-- TODO how to set @nodiscard for fields?

---@class minetest.InvRef
---@field get_stack fun(self : minetest.InvRef, listname : string, i : integer) : minetest.ItemStack
---@field set_stack fun(self : minetest.InvRef, listname : string, i : integer, stack : minetest.ItemStack)

---@class minetest.ItemStack
---@field is_empty fun(self : minetest.ItemStack) : boolean
---@field get_name fun(self : minetest.ItemStack) : string
---@field get_meta fun(self : minetest.ItemStack) : minetest.ItemStackMetaRef

---@class minetest.ItemStackMetaRef : minetest.MetaDataRef

---@class minetest.LuaEntity : minetest.ObjectRef

---@class minetest.MetaDataRef
---@field get fun(self : minetest.MetaDataRef, key : string) : string?
---@field set_string fun(self : minetest.MetaDataRef, key : string, value : string)
---@field get_string fun(self : minetest.MetaDataRef, key : string) : string
---@field set_int fun(self : minetest.MetaDataRef, key : string, value : integer)
---@field get_int fun(self : minetest.MetaDataRef, key : string) : integer

---@class minetest.ObjectRef

---@class minetest.Player : minetest.ObjectRef
---@field get_player_name fun(self : minetest.Player) : string
-- Actually an ObjectRef method, but returns nil on anything other than a player,
-- so let's put it here and avoid the nil
---@field get_inventory fun(self : minetest.Player) : minetest.InvRef
---@field get_wield_index fun(self : minetest.Player) : integer

-- Helper functions
-------------------

---@param arg any
---@return boolean
---@nodiscard
--- * returns true if passed 'y', 'yes', 'true' or a number that isn't zero.
function minetest.is_yes(arg) end

-- Utilities
------------

---@param modname string
---@return string?
---@nodiscard
function minetest.get_modpath(modname) end

-- Registration functions
-------------------------

-- * Environment
----------------

---@param name string
---@param definition minetest.ItemDef
function minetest.register_tool(name, definition) end

-- * Gameplay
-------------

---@param name string
---@param definition string | minetest.PrivilegeDef | nil
--- * `definition` can be a description or a definition table (see [Privilege
---   definition]).
--- * If it is a description, the priv will be granted to singleplayer and admin
---   by default.
--- * To allow players with `basic_privs` to grant, see the `basic_privs`
---   minetest.conf setting.
function minetest.register_privilege(name, definition) end

-- Global callback registration functions
-----------------------------------------

---@param on_player_receive_fields fun(player : minetest.Player, formname : string, fields : {[string]: string})
--- * Called when the server received input from `player` in a formspec with
---   the given `formname`. Specifically, this is called on any of the
---   following events:
---       * a button was pressed,
---       * Enter was pressed while the focus was on a text field
---       * a checkbox was toggled,
---       * something was selected in a dropdown list,
---       * a different tab was selected,
---       * selection was changed in a textlist or table,
---       * an entry was double-clicked in a textlist or table,
---       * a scrollbar was moved, or
---       * the form was actively closed by the player.
--- * Fields are sent for formspec elements which define a field. `fields`
---   is a table containing each formspecs element value (as string), with
---   the `name` parameter as index for each. The value depends on the
---   formspec element type:
---     * `animated_image`: Returns the index of the current frame.
---     * `button` and variants: If pressed, contains the user-facing button
---       text as value. If not pressed, is `nil`
---     * `field`, `textarea` and variants: Text in the field
---     * `dropdown`: Either the index or value, depending on the `index event`
---       dropdown argument.
---     * `tabheader`: Tab index, starting with `"1"` (only if tab changed)
---     * `checkbox`: `"true"` if checked, `"false"` if unchecked
---     * `textlist`: See `minetest.explode_textlist_event`
---     * `table`: See `minetest.explode_table_event`
---     * `scrollbar`: See `minetest.explode_scrollbar_event`
---     * Special case: `["quit"]="true"` is sent when the user actively
---       closed the form by mouse click, keypress or through a button_exit[]
---       element.
---     * Special case: `["key_enter"]="true"` is sent when the user pressed
---       the Enter key and the focus was either nowhere (causing the formspec
---       to be closed) or on a button. If the focus was on a text field,
---       additionally, the index `key_enter_field` contains the name of the
---       text field. See also: `field_close_on_enter`.
--- * Newest functions are called first
--- * If function returns `true`, remaining functions are not called
function minetest.register_on_player_receive_fields(on_player_receive_fields) end

-- Authentication
-----------------

---@param privs minetest.Privs
---@return string
---@nodiscard
--- * Returns the string representation of `privs`
--- * `delim`: String to delimit privs. Defaults to `","`.
function minetest.privs_to_string(privs) end

---@param player_or_name minetest.Player | string
---@param ... string
---@return boolean,minetest.Privs # Result, missing privileges
---@overload fun(player_or_name : minetest.Player | string, privs : minetest.Privs)
---@nodiscard
function minetest.check_player_privs(player_or_name, ...) end

-- Chat
-------

---@param text string
function minetest.chat_send_all(text) end

---@param name string
---@param text string
function minetest.chat_send_player(name, text) end

---@param name string
---@param message string
---@return string
---@nodiscard
--- * Used by the server to format a chat message, based on the setting `chat_message_format`.
---   Refer to the documentation of the setting for a list of valid placeholders.
--- * Takes player name and message, and returns the formatted string to be sent to players.
--- * Can be redefined by mods if required, for things like colored names or messages.
--- * **Only** the first occurrence of each placeholder will be replaced.
function minetest.format_chat_message(name, message) end

-- Environment access
---------------------

---@param pos vector.Vector
---@param node minetest.NodeOpt
function minetest.set_node(pos, node) end

---@param pos vector.Vector
--- * By default it does the same as `minetest.set_node(pos, {name="air"})`
function minetest.remove_node(pos) end

---@param pos vector.Vector
---@return minetest.Node
---@nodiscard
--- * Returns the node at the given position as table in the format
---   `{name="node_name", param1=0, param2=0}`,
---   returns `{name="ignore", param1=0, param2=0}` for unloaded areas.
function minetest.get_node(pos) end

-- Formspec
-----------

---@param playername string
---@param formname string
---@param formspec string
--- * `playername`: name of player to show formspec
--- * `formname`: name passed to `on_player_receive_fields` callbacks.
---   It should follow the `"modname:<whatever>"` naming convention
--- * `formspec`: formspec to display
function minetest.show_formspec(playername, formname, formspec) end

-- Misc
-------

---@param table {[string]: any}
---@return string
---@nodiscard
function serialize(table) end

-- Translations
---------------

---@param textdomain string?
---@return function(str : string, ... : string) : string
---@nodiscard
function minetest.get_translator(textdomain) end

---@param textdomain string
---@param str string
---@param ... string
---@return string
---@nodiscard
function minetest.translate(textdomain, str, ...) end
