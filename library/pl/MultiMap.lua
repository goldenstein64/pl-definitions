
local class = require("pl.class")

---@meta
---# Class [`pl.MultiMap`](https://lunarmodules.github.io/Penlight/classes/pl.MultiMap.html)
---
---`MultiMap`, a `Map` which has multiple values per key.
---
---Derived from [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html#).
---
---Dependencies:
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#), 
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#), 
--- [`pl.List`](https://lunarmodules.github.io/Penlight/classes/pl.List.html#), 
--- [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html#)
---@class PLMultiMap : { [any]: any[] }, PLMap
---@overload fun(t?: PLMultiMap): PLMultiMap
local MultiMap = class()

---update a MultiMap using a table.
---@param self PLMultiMap
---@param t PLMultiMap|PLMap|{ [any]: any[] } -- either a Multimap or a map-like table.
function MultiMap:update(t) end

---add a new value to a key.  Setting a `nil` value removes the key.
---@param self PLMultiMap
---@param key any -- the key
---@param val any -- the value
function MultiMap:set(key, val) end

return MultiMap