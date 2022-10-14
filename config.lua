name = "Penlight"

words = {
	-- requiring "pl"
	"require%s*(\"pl\")",
	"require%s*\"pl\"",
	"require%s*('pl')",
	"require%s*'pl'",

	-- requiring local modules
	"require%s*(\"pl%.%w+\")",
	"require%s*\"pl%.%w+\"",
	"require%s*('pl%.%w+')",
	"require%s*'pl%.%w+'"
}

configs = {
	{
		key = "Lua.workspace.library",
		action = "add",
		value = "${3rd}/lfs" -- `pl.path` uses this module
	}
}