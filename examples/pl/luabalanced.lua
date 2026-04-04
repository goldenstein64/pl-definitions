local lb = require("pl.luabalanced")

--Extract Lua expression starting at position 4.
print(lb.match_expression("if x^2 + x > 5 then print(x) end", 4))
--> x^2 + x > 5     16

--Extract Lua string starting at (default) position 1.
print(lb.match_string([["test\"123" .. "more"]]))
--> "test\"123"     12
