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
---@class pl.MultiMapClass : pl.Class
---@overload fun<K, V>(t?: pl.MultiMap<K, V>|pl.Map<K, V>|{ [K]: V[] }): pl.MultiMap<K, V>
local MultiMapClass = class() --[[@as pl.MultiMapClass]]

---@class pl.MultiMapBase : pl.MapBase
local MultiMap = MultiMapClass --[[@as pl.MultiMapBase]]

---@class pl.MultiMap<K, V> : pl.MultiMapBase, pl.Instance

---@generic K, V
---@param self pl.MultiMap<K, V>
---@param t? pl.MultiMap<K, V>|pl.Map<K, V>|{ [K]: V[] }
function MultiMapClass:_init(t) end

---update a MultiMap using a table.
---@generic K, V
---@param self pl.MultiMap<K, V>
---@param t pl.MultiMap<K, V>|pl.Map<K, V>|{ [K]: V[] } -- either a Multimap or a map-like table.
function MultiMap:update(t) end

---add a new value to a key.  Setting a `nil` value removes the key.
---@generic K, V
---@param self pl.MultiMap<K, V>
---@param key K -- the key
---@param val V? -- the value
function MultiMap:set(key, val) end

return MultiMapClass
