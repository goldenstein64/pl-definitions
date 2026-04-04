---@type fun(a: unknown, b: unknown): boolean
local same = nil

local data = require("pl.data") ---@type pl.data

--[[ assuming the data at test.txt is:
x,y
10,20
2,5
40,50
]]
assert(same(data.read("test.txt"), { { 10, 20 }, { 2, 5 }, { 40, 50 }, fieldnames = { "x", "y" }, delim = "," }))

local d = assert(data.read("xyz.txt"))
local q = d:select("x,y,z where x > 3 and z < 2 sort by y")
for x, y, z in q do
	print(x, y, z)
end
