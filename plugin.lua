local uri = select(2, ...)

---@alias parser.compile.mode
---| 'Lua'
---| 'Nil'
---| 'Boolean'
---| 'String'
---| 'Number'
---| 'Name'
---| 'Exp'
---| 'Action'

---@alias parser.compile.version
---| 'Lua 5.1'
---| 'Lua 5.2'
---| 'Lua 5.3'
---| 'Lua 5.4'
---| 'LuaJIT'

---@class parser.compile.options
---@field nonstandardSymbols? { [string]: true? }
---@field special?            { [string]: string? }
---@field unicodeName?        boolean

---@type fun(lua: string, mode: parser.compile.mode, version: parser.compile.version, options: parser.compile.options): parser.state
local compile = require("parser.compile")
local luadoc = require("parser.luadoc") ---@type fun(state: parser.state)
local config = require("config") ---@type config.api

local SearchPLRequires = require("SearchPLRequires")

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

	local search = SearchPLRequires.new()

	return search:searchParserState(state)
end

return "hello"
