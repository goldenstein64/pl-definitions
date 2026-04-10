---@meta
---# Module [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html)
---
---Provides a reusable and convenient framework for creating classes in Lua.
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
---@class pl.ClassModule
---@overload fun(base?: pl.Class): pl.Class
---@overload fun(c: table, class_init_arg?: any): pl.Class
---@overload fun(base: pl.Class, class_init_arg: any, c?: table): pl.Class
local class = {}

---@class pl.Class
---@overload fun(...: any): pl.Instance
local Class = {}

---determines how an instance is created, defaults to returning `{}`
---@param ... any
---@return pl.Instance
function Class._create(...) end

---initializes an instance upon creation
---@param obj pl.Instance
---@param ... any -- parameters passed to the constructor
---@return table? new_obj -- _if_ a constructor returns a value, it becomes the object...
function Class._init(obj, ...) end

---initializes a subclass of this class upon creation
---@param cls pl.Class
---@param class_init_arg any -- parameter passed into `class(base, class_init_arg, c)`
function Class._class_init(cls, class_init_arg) end

---initializes an instance of a subclass of this class after the subclass's
---`_init` function runs
---@param obj pl.Instance
function Class._post_init(obj) end

---checks whether an instance is derived from this class. Works the other way around as `is_a`
---@param obj any
---@return boolean -- true if `obj` is derived from this class
---@nodiscard
function Class:class_of(obj) end

---cast an object to another class. It is not clever (or safe!) so use
---carefully.
---@param obj pl.Instance -- the object to be changed
---@return pl.Instance obj -- the same object with its class changed
function Class:cast(obj) end

---@param handler fun(self: pl.Class, key: any): (value: any)
function Class.catch(handler) end

---set a handler for methods/properties not found in the class
---@param handler fun(self: pl.Class, key: any): (value: any)
function Class:catch(handler) end

---@protected
---@type (fun(self: pl.Class, key: any): (value: any))?
Class._handler = nil

---@class pl.Instance
local Instance = {}

---checks whether an instance is derived from some class. Works the other way
---around as class_of. It has two ways of using; 1) call with a class to check
---against, 2) call without params.
---@param cls any -- class to check against, or `nil` to return the class
---@return boolean -- `true` if instance is derived from `cls`
---@nodiscard
function Instance:is_a(cls) end

---returns a reference to this instance's class
---@return pl.Class
---@nodiscard
function Instance:is_a() end

---calls the superclass' constructor. **This method exists _if and only if_ it's
---called in its constructor and the superclass exists.**
---@param ... any
function Instance:super(...) end

---@protected
---A reference to an instance's class. Use `Instance:is_a()` to do the same.
---@type pl.Class
Instance._class = nil

---adds property lookups to the class
---
---for getter resolution of a key `prop`, it looks for:
---- `self.prop`
---- `Class.prop`
---- `Class.get_prop(self)`
---- If `self.prop` is `nil` and the rest are falsy, it defaults to the value of
---  `self._prop`.
---
---for setter resolution of a key `prop` and `value`, it looks for:
---- `self.prop = value`
---- `Class.set_prop(self, value)`
---- If `self.prop` is `nil` and `Class.set_prop` is falsy, it defaults to
---  `self.prop = value`.
---@type pl.Class
class.properties = nil

return class
