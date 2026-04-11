-- another way to define classes. Works particularly well
-- with Moonscript
local class = require("pl.class") --[[@as pl.ClassModule]]

---@class test-class3.A : test-class3.ABase, pl.Instance
---@field name string

---@class test-class3.ABase
local ABase = {
	---@param self test-class3.A
	---@param name string
	_init = function(self, name)
		self.name = name
	end,

	---@param self test-class3.A
	---@return string
	greet = function(self)
		return "hello " .. self.name
	end,

	---@param self test-class3.A
	---@return string
	__tostring = function(self)
		return self.name
	end,
}

---@class test-class3.AClass : test-class3.ABase, pl.Class
---@overload fun(name: string): test-class3.A
local A = class(ABase) --[[@as test-class3.AClass]]

---@class test-class3.B : test-class3.BBase, test-class3.A

---@class test-class3.BBase : test-class3.ABase
---@field _base nil
local BBase = {
	_base = A,

	---@param self test-class3.B
	---@return string
	greet = function(self)
		return "hola " .. self.name
	end,
}

---@class test-class3.BClass : test-class3.BBase, test-class3.AClass
local B = class(BBase)

local a = A("john")
assert(a:greet() == "hello john")
assert(tostring(a) == "john")
local b = B("juan")
assert(b:greet() == "hola juan")
assert(tostring(b) == "juan")
