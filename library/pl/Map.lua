local class = require("pl.class")

---@meta
---# Class [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html)
---
---A Map class.
---
---```lua
---> Map = require 'pl.Map'
---> m = Map{one=1, two=2}
---> m:update {three=3, four=4, two=20}
---> = m == M{one=1, two=20, three=3, four=4}
---true
---```
---
---Dependencies:
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#),
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#),
--- [`pl.tablex`](https://lunarmodules.github.io/Penlight/libraries/pl.tablex.html#),
--- [`pl.pretty`](https://lunarmodules.github.io/Penlight/libraries/pl.pretty.html#)
---@class pl.MapClass : pl.MapBase, pl.Class
---@overload fun<K, V>(t?: { [K]: V }): pl.Map<K, V>
---@overload fun<K, V>(t?: pl.Map<K, V>): pl.Map<K, V>
---@overload fun<K>(t?: pl.Set<K>): pl.Map<K, true?>
local MapClass = class() --[[@as pl.MapClass]]

---@class pl.MapBase
local Map = MapClass --[[@as pl.MapBase]]

---@class pl.Map<K, V> : { [K]: V }, pl.MapBase, pl.Instance

---@generic K, V
---@param self pl.Map<K, V>
---@param t? pl.Map<K, V>
---@overload fun<K, V>(t?: { [K]: V }): pl.Map<K, V>
---@overload fun<K>(t?: pl.Set<K>): pl.Map<K, true?>
function MapClass:_init(t) end

---return a List of all keys.
---@generic K
---@param self pl.Map<K, any>
---@return pl.List<K>
---@nodiscard
function Map:keys() end

---return a List of all values.
---@generic V
---@param self pl.Map<any, V>
---@return pl.List<V>
---@nodiscard
function Map:values() end

---return an iterator over all key-value pairs.
---@generic K, V
---@param self pl.Map<K, V>
---@return fun<K, V>(state: { [K]: V }, k: K?): (K, V) next, self state
---@nodiscard
function Map:iter() end

---return a List of all key-value pairs, sorted by the keys in ascending order.
---@generic K, V
---@param self pl.Map<K, V>
---@return pl.List<[K, V]>
---@nodiscard
function Map:items() end

---set a value in the map if it doesn't exist yet.
---@generic K, V
---@param self pl.Map<K, V>
---@param key K -- the key
---@param default V -- value to set
---@return V -- the value stored in the map (existing value, or the new value)
function Map:setdefault(key, default) end

---size of map. note: this is a relatively expensive operation!
---@param self pl.Map<any, any>
---@return integer
---@nodiscard
function Map:len() end

---put a value into the map. This will remove the key if the value is nil
---@generic K, V
---@param self pl.Map<K, V>
---@param key K -- the key
---@param val V -- the value
function Map:set(key, val) end

---get a value from the map.
---@generic K, V
---@param self pl.Map<K, V>
---@param key K -- the key
---@return V val -- the value, or `nil` if not found.
---@nodiscard
function Map:get(key) end

---get a list of values indexed by a list of keys.
---@generic K, V
---@param self pl.Map<K, V>
---@param keys pl.List<K> -- a list-like table of keys
---@return pl.List<V> values -- a new list
---@nodiscard
function Map:getvalues(keys) end

---update the map using key/value pairs from another table.
---@generic K, V
---@param self pl.Map<K, V>
---@param table pl.Map<K, V>|{ [K]: V }
function Map:update(table) end

---equality between maps.
---@param self pl.Map<any, any>
---@param m pl.Map<any, any> -- another map.
---@return boolean
---@nodiscard
function Map:__eq(m) end

---string representation of a map.
---@param self pl.Map<any, any>
---@return string
---@nodiscard
function Map:__tostring() end

return MapClass
