local guide = require("parser.guide")

---A class for implementing
---@class plugin.util.SearchRequires
---@field diffs diff[]
---@field diffSet { [diff]: true? }
---@field eachCallCallback fun(src: parser.object): true?
---@field eachDocModuleCallback fun(src: parser.object): true?
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

	function self.eachCallCallback(src)
		return self:eachCall(src)
	end

	function self.eachDocModuleCallback(src)
		return self:eachDocModule(src)
	end

	return setmetatable(self, SearchRequires)
end

---checks the `importMap` for `requireName` and adds its value to its diffs if
---found. Use this as the default behavior in `tryRequireName`
---@protected
---@param requireName string
---@return true?
function SearchRequires:writeFromRequireMap(requireName)
	local newRequire = self.diffMap[requireName]
	if newRequire and not self.diffSet[newRequire] then
		self.diffSet[newRequire] = true
		table.insert(self.diffs, newRequire)
	end

	return nil
end

---checks `requireName` and sets `self.diffs` if anything was found. Override
---this if you want different behavior.
---@protected
---@param requireName string
---@return true? stop -- stop searching if `true`
function SearchRequires:tryRequireName(requireName)
	return self:writeFromRequireMap(requireName)
end

---@private
---@param src parser.object
---@return true?
function SearchRequires:eachCall(src)
	local caller = src.node
	local firstArg = src.args and src.args[1]

	if caller.special == "require" and firstArg then
		return self:tryRequireName(firstArg[1])
	end
end

---@private
---@param src parser.object
---@return true?
function SearchRequires:eachDocModule(src)
	self:tryRequireName(src.module)
end

---Search this syntax tree state for a '---@module' annotation or a 'require'
---call
---@param state parser.state -- the syntax tree state to check
function SearchRequires:searchParserState(state)
	guide.eachSourceType(state.ast, "call", self.eachCallCallback)
	guide.eachSourceType(state.ast, "doc.module", self.eachDocModuleCallback)

	return self.diffs
end

return SearchRequires
