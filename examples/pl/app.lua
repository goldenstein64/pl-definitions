---@meta

---@type fun(a: unknown, b: unknown): boolean
local same = nil

local app = require("pl.app") ---@type pl.app

print(app.appfile("test.txt")) --> /absolute/path/to/test.txt

print(app.lua()) --> "lua -lluacov -e 'print(_VERSION)'", "lua"

-- Simple form:
local flags, params = app.parse_args(
	nil,
	{ "hello", "world" }, -- list of flags taking values
	{ "l", "a", "b" } -- list of allowed flags (value ones will be added)
)

-- More complex example using aliases:
local valid = {
	long = "l", -- if 'l' is specified, it is reported as 'long'
	new = { "n", "old" }, -- here both 'n' and 'old' will go into 'new'
}
local values = {
	"value", -- will automatically be added to the allowed set of flags
	"new", -- will mark 'n' and 'old' as requiring a value as well
}
-- command:  myapp.lua -l --old:hello --value world param1 param2
local flags, params = app.parse_args({ "-l", "--old:hello", "--value", "world", "param1", "param2" }, values, valid)

assert(same(flags, {
	long = true, -- input from 'l'
	new = "hello", -- input from 'old'
	value = "world", -- allowed because it was in 'values', note: space separated!
}))
assert(same(params, {
	[1] = "param1",
	[2] = "param2",
}))
