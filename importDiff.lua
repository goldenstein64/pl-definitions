local childrenProc = io.popen('dir "library/pl" /B', "r")
if not childrenProc then
	return
end

---@type string?
local childrenString = childrenProc:read("*a")
if not childrenString then
	return
end

local deprecatedMap = {
	["text"] = "use pl.stringx",
	["xml"] = "use a more specialized library instead",
}

---@type string[]
local importsTable = {}
for child in childrenString:gmatch("[^\n]+") do
	local childName = child:match("(.+)%.lua$")

	local importStatement
	local deprecated = deprecatedMap[childName]
	if deprecated then
		importStatement =
			string.format('_G.%s = require("pl.%s") ---@deprecated -- %s', childName, childName, deprecated)
	else
		importStatement = string.format('_G.%s = require("pl.%s")', childName, childName)
	end
	table.insert(importsTable, importStatement)
end

local imports = string.format("%s\n", table.concat(importsTable, "\n"))

local importsFile = io.open("imports.txt", "w")
if not importsFile then
	error("imports.txt not found")
end
importsFile:write(imports)
