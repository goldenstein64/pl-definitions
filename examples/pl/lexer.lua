local lexer = require("pl.lexer")

local s = "for i=1,n do"

for t, v in lexer.lua(s) do
	print(t, v)
end

--> keyword   for
--> iden      i
--> =         =
--> number    1
--> ,         ,
--> iden      n
--> keyword   do
