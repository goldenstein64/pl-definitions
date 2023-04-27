---a for loop where the body is substituted with `fun`. If `fun` returns `true`
---it breaks the for loop and returns `true`, `false` otherwise
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

---A class for implementing
---@class plugin.util.SearchRequires
---@field diffs diff[]
---@field diffSet { [diff]: true? }
local SearchRequires = {}
SearchRequires.__index = SearchRequires

---@type { [string]: diff? }
SearchRequires.diffMap = {}

---creates a new SearchRequires instance. `self.diffs` stores what diffs to add
---@return plugin.util.SearchRequires
function SearchRequires.new()
	local self = {
		diffs = {},
		diffSet = {},
	}

	return setmetatable(self, SearchRequires)
end

---checks the `importMap` for `requireName` and adds its value to its diffs if
---found. Use this as the default behavior in `tryRequireName`
---@protected
---@param requireName string
---@return boolean
function SearchRequires:writeFromRequireMap(requireName)
	local newRequire = self.diffMap[requireName]
	if newRequire and not self.diffSet[newRequire] then
		self.diffSet[newRequire] = true
		table.insert(self.diffs, newRequire)
	end

	return false
end

---checks `requireName` and sets `self.diffs` if anything was found. Override
---this if you want different behavior.
---@protected
---@param requireName string
---@return boolean stop -- stop searching if `true`
function SearchRequires:tryRequireName(requireName)
	return self:writeFromRequireMap(requireName)
end

---@private
function SearchRequires:maybeSearchModuleDoc(doc)
	if doc.type == "doc.module" then
		return self:tryRequireName(doc.module)
	end
end

---@private
function SearchRequires:searchForModuleDoc(docs)
	return breakFor(function(_, doc)
		return self:maybeSearchModuleDoc(doc)
	end, ipairs(docs))
end

---@private
function SearchRequires:maybeSearchRequireCall(call)
	local firstArg = call.args and call.args[1]
	if firstArg and firstArg.type == "string" then
		return self:tryRequireName(firstArg[1])
	end
end

---@private
function SearchRequires:maybeSearchRequireRef(ref)
	local call = ref.parent
	if call and call.type == "call" then
		return self:maybeSearchRequireCall(call)
	end
end

---@private
function SearchRequires:searchRequireCalls(requireRefs)
	return breakFor(function(_, ref)
		return self:maybeSearchRequireRef(ref)
	end, ipairs(requireRefs))
end

---Search this syntax tree state for a '---@module' annotation or a 'require'
---call
---@param state table -- the syntax tree state to check
function SearchRequires:searchParserState(state)
	-- check doc comments
	if state.ast.docs then
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
