-- Module containing classes
local class = require("pl.class") ---@type pl.ClassModule
local utils = require("pl.utils") ---@type pl.utils
local error = error

local animal = {}

---@class AnimalClass : AnimalBase, pl.Class
---@overload fun(name: string): Animal
local Animal = class() --[[@as AnimalClass]]

---@class AnimalBase
---@field speak fun(self: Animal): string
local AnimalBase = animal.Animal --[[@as AnimalBase]]

---@class Animal : AnimalBase, pl.Instance

---@param self Animal
---@param name string
function AnimalBase:_init(name)
	self.name = name
end

---@param self Animal
function AnimalBase:__tostring()
	return self.name .. ": " .. self:speak()
end

---@class DogClass : DogBase, AnimalClass
---@overload fun(name: string): Dog
local Dog = class(Animal) --[[@as DogClass]]

---@class DogBase : AnimalBase
local DogBase = Dog --[[@as DogBase]]

---@class Dog : DogBase, Animal

---@param self Dog
function DogBase:speak()
	return "bark"
end

---@class CatClass : CatBase, AnimalClass
---@overload fun(name: string, breed: string): Cat
local Cat = class(Animal) --[[@as CatClass]]

---@class CatBase : AnimalBase
local CatBase = Cat --[[@as CatBase]]

---@class Cat : CatBase, Animal

---@param self Cat
---@param name string
---@param breed string
function Cat:_init(name, breed)
	self:super(name) -- must init base!
	self.breed = breed
end

---@param self Cat
function Cat:speak()
	return "meow"
end

---@class Lion : LionBase, Cat

-- you may declare the methods in-line like so;
-- note the meaning of `_base`!
---@class LionClass : LionBase, CatClass
---@overload fun(name: string, breed: string): Lion
local Lion = class(
	---@class LionBase : CatBase
	{
		_base = Cat,
		---@param self Lion
		speak = function(self)
			return "roar"
		end,
	}
) --[[@as LionClass]]

-- a class may handle unknown methods with `catch`:
Lion:catch(function(self, name)
	return function()
		error("no such method " .. name, 2)
	end
end)

return {
	Animal = Animal,
	Dog = Dog,
	Cat = Cat,
	Lion = Lion,
}
