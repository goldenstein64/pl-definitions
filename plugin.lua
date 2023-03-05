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

local statements = {}
for child in childrenString:gmatch("[^\n]+") do
	local childName = child:match("(.+)%.lua$")

	local statement
	local deprecated = deprecatedMap[childName]
	if deprecated then
		statement = string.format('_G.%s = require("pl.%s") ---@deprecated -- %s', childName, childName, deprecated)
	else
		statement = string.format('_G.%s = require("pl.%s")', childName, childName)
	end
	table.insert(statements, statement)
end

local statementString = string.format("\n%s", table.concat(statements, "\n"))

---@class diff
---@field start  integer # The number of bytes at the beginning of the replacement
---@field finish integer # The number of bytes at the end of the replacement
---@field text   string  # What to replace

---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text)
	if uri:match("plugin%.lua$") or uri:match("diffed%.lua$") or uri:match("diff%.lua$") then
		return
	end

	-- TODO: detect comments and don't count them
	local endPos = text:match('require%s*%(%s*"pl"%s*%)()')
		or text:match("require%s*%(%s*'pl'%s*%)()")
		or text:match('require%s*"pl"()')
		or text:match("require%s*'pl'()")

	if not endPos then
		return
	end

	return {
		{
			start = endPos,
			finish = endPos,
			text = statementString
		}
	}
end
