local SearchRequires = require("SearchRequires")

---diff for the imports for 'pl.compat'
---@type diff
local importCompatDiff = {
	start = 1,
	finish = 0,
	text = require("importCompatDiff"),
}

---diff for the imports for 'pl', which is everything
---@type diff
local importDiff = {
	start = 1,
	finish = 0,
	text = require("importDiff"),
}

---diff array for all imports, equivalent to requiring 'pl'
---@type diff[]
local importAll = { importDiff }

---@class plugin.penlight.SearchPLRequires : plugin.util.SearchRequires
local SearchPLRequires = setmetatable({}, SearchRequires)
SearchPLRequires.__index = SearchPLRequires

SearchPLRequires.diffMap = {
	["pl.compat"] = importCompatDiff,
}

function SearchPLRequires.new()
	local self = SearchRequires.new()

	return setmetatable(self, SearchPLRequires)
end

---@protected
---@param requireName string
---@return boolean stop -- stop searching if `true`
function SearchPLRequires:tryRequireName(requireName)
	if requireName == "pl" then
		self.diffs = importAll
		return true
	end

	return self:writeFromRequireMap(requireName)
end

return SearchPLRequires
