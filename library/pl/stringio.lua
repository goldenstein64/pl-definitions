---# Module [`pl.stringio`](https://lunarmodules.github.io/Penlight/libraries/pl.stringio.html)
---
---Reading and writing strings using file-like objects.
---
---```lua
---f = stringio.open(text)
---l1 = f:read()  -- read first line
---n,m = f:read ('*n','*n') -- read two numbers
---for line in f:lines() do print(line) end -- iterate over all lines
---f = stringio.create()
---f:write('hello')
---f:write('dolly')
---assert(f:value(),'hellodolly')
---```
---
---See [the Guide](https://lunarmodules.github.io/Penlight/manual/03-strings.md.html#File_style_I_O_on_Strings).
local stringio = {}

---@class PLStringIOWriter
local stringIOWriter = {}

---@param self PLStringIOWriter
---@param ... string
function stringIOWriter:write(...) end

---@param self PLStringIOWriter
---@param fmt string
---@param ... any
function stringIOWriter:writef(fmt, ...) end

---@param self PLStringIOWriter
---@return string
---@nodiscard
function stringIOWriter:value() end

---for compatibility only
function stringIOWriter:close() end

---for compatibility only
function stringIOWriter:seek() end

---@class PLStringIOReader
local stringIOReader = {}

---@param ... "*l"|"*L"|"*a"|"*n"|integer
---@return string|integer ...
function stringIOReader:read(...) end

---@param self PLStringIOReader
---@param whence "set"|"cur"|"end"
---@param offset? integer
function stringIOReader:seek(whence, offset) end

---@param ... "*l"|"*L"|"*a"|"*n"|integer
---@return fun(): (...: string|integer)
---@nodiscard
function stringIOReader:lines(...) end

---for compatibility only
function stringIOReader:close() end

---create a file-like object which can be used to construct a string. The 
---resulting object has an extra `value()` method for retrieving the string 
---value. Implements `file:write`, `file:seek`, `file:lines`, plus an extra 
---`writef` method which works like `utils.printf`.
---@return PLStringIOWriter
---@nodiscard
---
---Usage:
---
---```lua
---f = stringio.create()
---f:write('hello, dolly\n')
---print(f:value())
---```
function stringio.create() end

---create a file-like object for reading from a given string. Implements 
---`file:read`.
---@param s string -- The input string.
---@return PLStringIOReader
---@nodiscard
---
---Usage:
---
---```lua
---f = stringio.open '20 10'
---x,y = f:read ('*n','*n')
---assert(x == 20 and y == 10)
---```
function stringio.open(s) end

return stringio