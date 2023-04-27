local uri = select(2, ...)

local inspect = require("inspect")
local compile = require("parser.compile")
local luadoc = require("parser.luadoc")
local config = require("config") ---@type unknown

local runtimeVersion = config.get(uri, "Lua.runtime.version")

---@type diff
local importCompatDiff = {
	start = 1,
	finish = 0,
	text = require("importCompatDiff"),
}

---@type diff
local importDiff = {
	start = 1,
	finish = 0,
	text = require("importDiff"),
}

local importAll = { importDiff }

local function tryRequireName(diffs, diffSet, requireName)
	if requireName == "pl" then
		return true, importAll
	elseif requireName == "pl.compat" and not diffSet[importCompatDiff] then
		diffSet[importCompatDiff] = true
		table.insert(diffs, importCompatDiff)
		return false, diffs
	end
end

local function searchForModuleDoc(diffs, diffSet, docs)
	for i, doc in ipairs(docs) do
		print(i, inspect(doc))
		if doc.type == "doc.module" then
			local stop, newDiffs = tryRequireName(diffs, diffSet, doc.module)
			if stop then
				return true, newDiffs
			end
		end
	end

	return false, diffs
end

local function searchRequireCalls(diffs, diffSet, requireRefs)
	for _, ref in ipairs(requireRefs) do
		local call = ref.parent
		if call and call.type == "call" then
			local firstArg = call.args and call.args[1]
			if firstArg and firstArg.type == "string" then
				local module = firstArg[1]
				local stop, newDiffs = tryRequireName(diffs, diffSet, module)
				if stop then
					return true, newDiffs
				end
			end
		end
	end

	return false, diffs
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
	local state = compile(text, "Lua", runtimeVersion, {})
	luadoc(state)
	print(inspect(state))

	local diffSet = {}
	local diffs = {}

	-- check doc comments
	-- print(state.docs)
	if state.ast.docs then
		local stop, newDiffs = searchForModuleDoc(diffs, diffSet, state.ast.docs)
		if stop then
			return newDiffs
		end
	end

	-- check the require statements
	if state.specials and state.specials.require then
		local stop, newDiffs = searchRequireCalls(diffs, diffSet, state.specials.require)
		if stop then
			return newDiffs
		end
	end

	return diffs
end

return "hello"
