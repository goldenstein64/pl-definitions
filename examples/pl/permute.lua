local permute = require("pl.permute")
local utils = require("pl.utils")

---@type fun(a: unknown, b: unknown): boolean
local same = nil

assert(
	same(
		permute.order_table({ 1, 2, 3 }),
		{ { 2, 3, 1 }, { 3, 2, 1 }, { 3, 1, 2 }, { 1, 3, 2 }, { 2, 1, 3 }, { 1, 2, 3 } }
	)
)

local strs = utils.pack("one", nil, "three") -- adds an 'n' field for nil-safety
local bools = utils.pack(true, false)
local iter = permute.list_iter(strs, bools)

assert(same({ iter() }, { "one", true }))
assert(same({ iter() }, { nil, true }))
assert(same({ iter() }, { "three", true }))
assert(same({ iter() }, { "one", false }))
assert(same({ iter() }, { nil, false }))
assert(same({ iter() }, { "three", false }))

local strs = utils.pack("one", nil, "three") -- adds an 'n' field for nil-safety
local bools = utils.pack(true, false)
local results = permute.list_table(strs, bools)
assert(same(results, {
	{ "one", true, n = 2 },
	{ nil, true, n = 2 },
	{ "three", true, n = 2 },
	{ "one", false, n = 2 },
	{ nil, false, n = 2 },
	{ "three", false, n = 2 },
}))
