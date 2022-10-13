name = "PenLight (global)"

words = {
	"require%s*(\"pl\")",
	"require%s*\"pl\"",
	"require%s*('pl')",
	"require%s*'pl'"
}

configs = {
	{
		key = "Lua.workspace.library",
		action = "add",
		value = "${3rd}/lfs" -- `pl.path` uses this module
	}
}