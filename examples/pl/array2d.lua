---@meta

---@type fun(a: unknown, b: unknown): boolean
local same = nil

local array2d = require("pl.array2d")

local product = array2d.product
local flatten = array2d.flatten

assert(same(product("..", { 1, 2 }, { "a", "b" }), { { "1a", "2a" }, { "1b", "2b" } }))

assert(same(flatten({ { 1, 2 }, { 3, 4 }, { 5, 6 } }), { 1, 2, 3, 4, 5, 6 }))
