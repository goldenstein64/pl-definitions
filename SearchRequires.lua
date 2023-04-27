---@param fun fun(...: any): boolean
---@param ... ...any
---@return boolean
local function breakFor(fun, ...)
	for k, v in ... do
		local stop = fun(k, v)
		if stop then
			return true
		end
	end

	return false
end

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

---@type diff[]
local importAll = { importDiff }

---@class plugin.penlight.SearchRequires
---@field diffs diff[]
---@field diffSet { [diff]: true? }
local SearchRequires = {}
SearchRequires.__index = SearchRequires

---@type { [string]: diff? }
SearchRequires.importMap = {
	["pl.compat"] = importCompatDiff,
}

---@return plugin.penlight.SearchRequires
function SearchRequires.new()
	local self = {
		diffs = {},
		diffSet = {},
	}

	setmetatable(self, SearchRequires)

	return self
end

---@param requireName string
---@return boolean stop
function SearchRequires:tryRequireName(requireName)
	if requireName == "pl" then
		self.diffs = importAll
		return true
	end

	local newImport = self.importMap[requireName]
	if newImport and not self.diffSet[newImport] then
		self.diffSet[newImport] = true
		table.insert(self.diffs, newImport)
	end

	return false
end

function SearchRequires:maybeSearchModuleDoc(doc)
	if doc.type == "doc.module" then
		return self:tryRequireName(doc.module)
	end
end

function SearchRequires:searchForModuleDoc(docs)
	return breakFor(function(_, doc)
		return self:maybeSearchModuleDoc(doc)
	end, ipairs(docs))
end

function SearchRequires:maybeSearchRequireCall(call)
	local firstArg = call.args and call.args[1]
	if firstArg and firstArg.type == "string" then
		return self:tryRequireName(firstArg[1])
	end
end

function SearchRequires:maybeSearchRequireRef(ref)
	local call = ref.parent
	if call and call.type == "call" then
		return self:maybeSearchRequireCall(call)
	end
end

function SearchRequires:searchRequireCalls(requireRefs)
	return breakFor(function(_, ref)
		return self:maybeSearchRequireRef(ref)
	end, ipairs(requireRefs))
end

function SearchRequires:searchParserState(state)
	-- check doc comments
	do
		local stop = self:searchForModuleDoc(state.ast.docs)
		if stop then
			return self.diffs
		end
	end

	-- check the require statements
	if state.specials and state.specials.require then
		local stop = self:searchRequireCalls(state.specials.require)
		if stop then
			return self.diffs
		end
	end

	return self.diffs
end

return SearchRequires
