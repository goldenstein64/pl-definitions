---@meta

---@type fun(a: unknown, b: unknown): boolean
local same = nil

local C = require("pl.comprehension").new()

C("x for x=1,10")() --> {1,2,3,4,5,6,7,8,9,10}
C("x^2 for x=1,4")() --> {1,4,9,16}
C("{x,x^2} for x=1,4")() --> {{1,1},{2,4},{3,9},{4,16}}
C("2*x for x")({ 1, 2, 3 }) --> {2,4,6}
local dbl = C("2*x for x")
dbl({ 10, 20, 30 }) --> {20,40,60}
C("x for x if x % 2 == 0")({ 1, 2, 3, 4, 5 }) --> {2,4}
C("{x,y} for x = 1,2 for y = 1,2")() --> {{1,1},{1,2},{2,1},{2,2}}
C("{x,y} for x for y")({ 1, 2 }, { 10, 20 }) --> {{1,10},{1,20},{2,10},{2,20}}
assert(same(C("sum(x^2 for x)")({ 2, 3, 4 }), 2 ^ 2 + 3 ^ 2 + 4 ^ 2))
