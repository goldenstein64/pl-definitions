local seq = require("pl.seq")
local operator = require("pl.operator")
local List = require("pl.List")

---@type fun(a: unknown, b: unknown): boolean
local same = nil

assert(9 == seq.sum(seq.list({ 1, 3, 5 })))

for x in seq.list({ 1, 3, 5 }) do
	print(x)
end

assert(same(List({ 1, 2, 3 }), seq.copy(seq.list({ 1, 2, 3 }))))

assert(same({ { 1, 10 }, { 2, 20 }, { 3, 30 } }, seq.copy2(ipairs({ 10, 20, 30 }))))

for x, y in seq.zip({ 1, 2, 3 }, { 10, 20, 30 }) do
	print(x, y)
end

assert(10 == seq.reduce(operator.add, seq.list({ 1, 2, 3, 4 })))
assert(-13 == seq.reduce("-", { 1, 2, 3, 4, 5 }))
