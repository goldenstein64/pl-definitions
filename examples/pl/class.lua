local class = require("pl.class") ---@type pl.class

local A = class()
local B = class(A)

--annotator note: this is hard to make definitions for, so it's not supported
class.B(A)

---@class Cat.class : pl.Class
---@overload fun(name: string): Cat
local Cat = class()

function Cat:_init(name)
	---@class Cat : pl.Instance, Cat.class
	self = self
	--self:super(name)   -- call the ancestor initializer if needed
	self.name = name
end

local pussycat = Cat("pussycat")
print(pussycat.name) --> pussycat

---@class Lion.class : Cat.class
---@overload fun(): Lion
local Lion = class(Cat)

---@class Lion : Cat, Lion.class

local pussycat = Lion() --[[@as Lion]]
assert(pussycat:is_a(Cat))
assert(pussycat:is_a() == Lion)

assert(Cat:class_of(pussycat))
