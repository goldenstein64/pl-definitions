local lexer = require("lexer")

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

---@type diff[]
local importResult = {
	{
		start = 1,
		finish = 0,
		text = imports,
	},
}

---@class diff
---@field start  integer # The number of bytes at the beginning of the replacement
---@field finish integer # The number of bytes at the end of the replacement
---@field text   string  # What to replace

---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text)
	-- comment this out when it's ready
	if not uri:match("penlight/test%.lua$") then
		return
	end

	---@type diff[]
	local diffs = {}

	local isRequire = false
	local nextToken = nil
	for valueType, value in lexer.lua(text, {}, { string = true }) do
		if isRequire then
			if nextToken == "(" and valueType == nextToken then
				nextToken = "string"
			elseif nextToken == "string" and valueType == nextToken and value == "pl" then
				nextToken = ")"
			elseif nextToken == ")" and valueType == nextToken then
				-- require completed!
				return importResult
			elseif valueType ~= "space" and valueType ~= "comment" then
				isRequire = false
			end
		elseif valueType == "iden" and value == "require" then
			isRequire = true
			nextToken = "("
			-- check if its argument is a form of 'pl'
		elseif valueType == "comment" then
			if
				value:find("^%-%-%[(=*)%[@module[ \t]*(['\"])pl%2.-%]%1%]")
				or value:find("^%-%-%-@module[ \t]*(['\"])pl%1")
			then
				return importResult
			end
		end
	end
end
