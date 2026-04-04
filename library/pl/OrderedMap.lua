local class = require("pl.class")

---@meta
---# Class [`pl.OrderedMap`](https://lunarmodules.github.io/Penlight/classes/pl.OrderedMap.html)
---
---`OrderedMap`, a `Map` which preserves ordering.
---
---Derived from [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html#).
---
---Dependencies:
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#),
--- [`pl.tablex`](https://lunarmodules.github.io/Penlight/libraries/pl.tablex.html#),
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#),
--- [`pl.List`](https://lunarmodules.github.io/Penlight/classes/pl.List.html#),
--- [`pl.Map`](https://lunarmodules.github.io/Penlight/classes/pl.Map.html#)
---@class pl.OrderedMapClass : pl.OrderedMapBase, pl.Class
---@overload fun<K, V>(t?: {[K]: V}|{[K]: V}[]|pl.OrderedMap<K, V>): pl.OrderedMap<K, V>
local OrderedMapClass = class() --[[@as pl.OrderedMapClass]]

---@class pl.OrderedMapBase : pl.MapBase
local OrderedMap = OrderedMapClass --[[@as pl.OrderedMapBase]]

---@class pl.OrderedMap<K, V> : pl.OrderedMapBase, pl.Instance

---construct an `OrderedMap`. Will throw an error if the argument is bad.
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@param t? {[K]: V}|{[K]: V}[]|pl.OrderedMap<K, V> -- optional initialization table, same as for `OrderedMap:update`
function OrderedMapClass:_init(t) end

---update an `OrderedMap` using a table. If the table is itself an
---`OrderedMap`, then its entries will be appended. if it is a table of the
---form `{{key1 = val1}, {key2 = val2}, ...}` these will be appended.
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@param t {[K]: V}|{[K]: V}[]|pl.OrderedMap<K, V>
---@return pl.OrderedMap? self -- the map, or `nil` in case of error
---@return string? error_message -- the error message
function OrderedMap:update(t) end

---set the key's value. This key will be appended at the end of the map.
---
---If the value is nil, then the key is removed.
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@param key K -- the key
---@param val V -- the value
---@return self self -- the map
function OrderedMap:set(key, val) end

OrderedMap.__newindex = OrderedMap.set

---insert a key/value pair before a given position. Note: if the map already
---contains the key, then this effectively moves the item to the new position
---by first removing at the old position. Has no effect if the key does not
---exist and val is `nil`
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@param pos integer -- a position starting at 1
---@param key K -- the key
---@param val V -- the value; if `nil` use the old value
---@return self self
function OrderedMap:insert(pos, key, val) end

---return the keys in order. (Not a copy!)
---@generic K
---@param self pl.OrderedMap<K, any>
---@return pl.List<K>
---@nodiscard
function OrderedMap:keys() end

---return the values in order. this is relatively expensive.
---@generic V
---@param self pl.OrderedMap<any, V>
---@return pl.List<V>
---@nodiscard
function OrderedMap:values() end

---sort the keys.
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@param cmp? fun(key1: K, key2: K): boolean -- a comparison function as for `table.sort`
---@return self self
function OrderedMap:sort(cmp) end

---iterate over key-value pairs in order.
---@generic K, V
---@param self pl.OrderedMap<K, V>
---@return fun(): (K, V)
---@nodiscard
function OrderedMap:iter() end

---iterate over an ordered map (5.2).
OrderedMap.__pairs = OrderedMap.iter

---string representation of an ordered map.
---@param self pl.OrderedMap<any, any>
---@return string
---@nodiscard
function OrderedMap:__tostring() end

return OrderedMapClass
