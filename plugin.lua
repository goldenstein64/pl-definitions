local compile = require("parser.compile")
local luadoc = require("parser.luadoc")
local config = require("config")
local util = require("utility")

local SearchPLRequires = require("SearchPLRequires")

local function compileState(uri, text)
	local options = {
		special = config.get(uri, "Lua.runtime.special"),
		unicodeName = config.get(uri, "Lua.runtime.unicodeName"),
		nonstandardSymbol = util.arrayToHash(config.get(uri, "Lua.runtime.nonstandardSymbol")),
	}

	local version = config.get(uri, "Lua.runtime.version")

	local state = compile(text, "Lua", version, options)
	luadoc(state)

	return state
end

---@class diff
---@field start  integer # The number of bytes at the beginning of the replacement
---@field finish integer # The number of bytes at the end of the replacement
---@field text   string  # What to replace

---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text)
	--[ comment this out when it's ready
	if not uri:match("penlight/test%.lua$") then
		return
	end
	--]]

	local state = compileState(uri, text)

	local search = SearchPLRequires.new()

	search:searchParserState(state)

	return search.diffs
end
