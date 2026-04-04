local seq = require("pl.seq")
local input = require("pl.input")

local total, n = seq.sum(input.numbers())
print("average", total / n)

for x, y in input.fields({ 2, 3 }) do -- 2nd and 3rd fields from stdin
	print(x, y)
end
