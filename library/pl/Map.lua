local class = require("pl.class")

---@meta
---# Class [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html)
---
---A Map class.
---
---```lua
---> Map = require 'pl.Map'
---> m = Map{one=1,two=2}
---> m:update {three=3,four=4,two=20}
---> = m == M{one=1,two=20,three=3,four=4}
---true
---```
---
---Dependencies: 
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#), 
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#), 
--- [`pl.tablex`](https://lunarmodules.github.io/Penlight/libraries/pl.tablex.html#), 
--- [`pl.pretty`](https://lunarmodules.github.io/Penlight/libraries/pl.pretty.html#)
---@class PLMap : PLClass
---@overload fun(t?: PLMap|PLSet): PLMap
local Map = class()

---list of keys.
---@param self PLMap
---@return any[]
function Map:keys() end

---list of values.
---@param self PLMap
---@return any[]
function Map:values() end

---return an iterator over all key-value pairs.
---@param self PLMap
---@return fun(): (any, any)
function Map:iter() end

---return a List of all key-value pairs, sorted by the keys.
---@param self PLMap
---@return PLList
function Map:items() end

---set a value in the map if it doesn't exist yet.
---@param self PLMap
---@param key any -- the key
---@param default any -- value to set
---@return any -- the value stored in the map (existing value, or the new value)
function Map:setdefault(key, default) end

---size of map. note: this is a relatively expensive operation!
---@param self PLMap
---@return integer
function Map:len() end

---put a value into the map. This will remove the key if the value is nil
---@param self PLMap
---@param key any -- the key
---@param val any -- the value
function Map:set(key, val) end

---get a value from the map.
---@param self PLMap
---@param key any -- the key
---@return any val -- the value, or `nil` if not found.
function Map:get(key) end

---get a list of values indexed by a list of keys.
---@param self PLMap
---@param keys PLList -- a list-like table of keys
---@return PLList values -- a new list
function Map:getvalues(keys) end

---update the map using key/value pairs from another table.
---@param self PLMap
---@param table PLMap|table
function Map:update(table) end

---equality between maps.
---@param self PLMap
---@param m PLMap -- another map.
---@return boolean
function Map:__eq(m) end

---string representation of a map.
---@param self PLMap
---@return string
function Map:__tostring() end

return Map