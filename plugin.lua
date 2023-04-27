local uri = select(2, ...)

-- local inspect = require("inspect")
local compile = require("parser.compile")
local luadoc = require("parser.luadoc")
local config = require("config") ---@type unknown

local SearchRequires = require("SearchRequires")

local runtimeVersion = config.get(uri, "Lua.runtime.version")

---@class diff
---@field start  integer # The number of bytes at the beginning of the replacement
---@field finish integer # The number of bytes at the end of the replacement
---@field text   string  # What to replace

---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text)
	--[[ comment this out when it's ready
	if not uri:match("penlight/test%.lua$") then
		return
	end
	--]]
	local state = compile(text, "Lua", runtimeVersion, {})
	luadoc(state)

	local search = SearchRequires.new()

	return search:searchParserState(state)
end

return "hello"
