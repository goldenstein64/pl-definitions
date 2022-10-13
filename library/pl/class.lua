---@meta
---# Module [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html)
---
---Provides a reuseable and convenient framework for creating classes in Lua.
---
---Two possible notations:
---
---```lua
---B = class(A)
---class.B(A)
---```
---The latter form creates a named class within the current environment. Note 
---that this implicitly brings in [pl.utils](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html) as a dependency.
---
---See the Guide for further [discussion](https://lunarmodules.github.io/Penlight/manual/01-introduction.md.html#Simplifying_Object_Oriented_Programming_in_Lua)
---@class PLClassModule
---@operator call(PLClass?): PLClass
local class = {}

---@class PLClass
---@operator call(...): PLInstance
local Class = {}

---initializes an instance upon creation.
---@param ... any -- parameters passed to the constructor
function Class._init(...) end

---checks whether an instance is derived from this class. Works the other way around as `is_a`.
---@param some_instance PLInstance
---@return boolean -- true if `some_instance` is derived from this class
---@nodiscard
function class:class_of(some_instance) end

---cast an object to another class. It is not clever (or safe!) so use 
---carefully.
---@generic T: PLClass
---@param self T
---@param some_instance PLInstance -- the object to be changed
function class:cast(some_instance) end

---@class PLInstance
local Instance = {}

---checks whether an instance is derived from some class. Works the other way 
---around as class_of. It has two ways of using; 1) call with a class to check 
---against, 2) call without params.
---@param some_class PLClass -- class to check against, or `nil` to return the class
---@return boolean -- `true` if instance is derived from some_class
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Instance:is_a(some_class) end

---@return PLClass
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Instance:is_a() end

return class