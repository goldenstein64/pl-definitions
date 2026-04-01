local dir = require("pl.dir") ---@type pl.dir

local x = dir.clonetree(".", "../backup", dir.copyfile)
