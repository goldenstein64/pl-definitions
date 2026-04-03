---@meta
---# Module [`pl.func`](https://lunarmodules.github.io/Penlight/libraries/pl.func.html)
---
---Functional helpers like composition, binding and placeholder expressions.
---
---Placeholder expressions are useful for short anonymous functions, and were
---inspired by the Boost Lambda library.
---
---```lua
---> utils.import 'pl.func'
---> ls = List{10, 20, 30}
---> = ls:map(_1+1)
---{11, 21, 31}
---```
---
---They can also be used to *bind* particular arguments of a function.
---```lua
---> p = bind(print, 'start>', _0)
---> p(10, 20, 30)
---> start>   10   20  30
---```
---
---See [the Guide](https://lunarmodules.github.io/Penlight/manual/07-functional.md.html#Creating_Functions_from_Functions)
---
---Dependencies:
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#),
--- [`pl.tablex`](https://lunarmodules.github.io/Penlight/libraries/pl.tablex.html#)
---@class pl.func
local func = {}

---@class pl.PlaceholderExpressionFields
---@field op "X"|"[]"|"()"|"unm"|"not"|"#"|"or"|"and"|"=="|"~="|"<"|">"|"<="|">="|".."|"+"|"-"|"*"|"/"|"%"|"^"
---@field repr string
---@field index number|"wrap"
---@field private __PE_function function

---@class pl.PlaceholderExpression : pl.PlaceholderExpressionFields
---@operator add(any): pl.PlaceholderExpression
---@operator sub(any): pl.PlaceholderExpression
---@operator mul(any): pl.PlaceholderExpression
---@operator div(any): pl.PlaceholderExpression
---@operator mod(any): pl.PlaceholderExpression
---@operator pow(any): pl.PlaceholderExpression
---@operator unm: pl.PlaceholderExpression
---@operator concat(any): pl.PlaceholderExpression
---@operator len: pl.PlaceholderExpression
---@overload fun(...: any): pl.PlaceholderExpression
---@field [any] pl.PlaceholderExpression

---wrap a table of functions. This makes them available for use in placeholder expressions.
---@param tname string -- a table name
---@param context? table -- context to put results, defaults to environment of caller. **Must be a global if provided.**
function func.import(tname, context) end

---register a function for use in placeholder expressions.
---@param fun function -- a function
---@param name? string -- a name (optional)
---@return pl.PlaceholderExpression -- a placeholder function
function func.register(fun, name) end

---all elements of a table except the first.
---@generic T
---@param ls T[] -- a list-like table
---@return T[]
---@nodiscard
function func.tail(ls) end

---create a string representation of a placeholder expression.
---@param e pl.PlaceholderExpression -- a placeholder expression
---@return string
---@nodiscard
function func.repr(e) end

---collect all the non-PE values in this PE into vlist, and replace each occurrence
---with a constant placeholder. Return the maximum placeholder index found.
---@param e pl.PlaceholderExpression
---@param vlist unknown[]
---@return integer index
function func.collect_values(e, vlist) end

---create a raw placeholder expression
---@param t pl.PlaceholderExpressionFields
---@return pl.PlaceholderExpression
function func.PE(t) end

---@param value any
---@return boolean
function func.isPE(value) end

---instantiate a placeholder expression into an actual function. First we find
---the largest placeholder used, e.g. 2; from this a list of the formal
---parameters can be built. Then we collect and replace any non-PE values from
---the PE, and build up a constant binding list. Finally, the expression can be
---compiled, and `e.__PE_function` is set.
---@param e pl.PlaceholderExpression -- a placeholder expression
---@return function -- a function
function func.instantiate(e) end

---instantiate a placeholder expression unless it has already been done.
---@param e pl.PlaceholderExpression -- a placeholder expression
---@return function -- the function
function func.I(e) end

local empty = function() end

--- represents a variadic (`...`)
---@type pl.PlaceholderExpression
func._0 = nil

--- represents argument #1
---@type pl.PlaceholderExpression
func._1 = nil

--- represents argument #2
---@type pl.PlaceholderExpression
func._2 = nil

--- represents argument #3
---@type pl.PlaceholderExpression
func._3 = nil

--- represents argument #4
---@type pl.PlaceholderExpression
func._4 = nil

--- represents argument #5
---@type pl.PlaceholderExpression
func._5 = nil

---placeholder expression for `name`
---@param name string
---@return pl.PlaceholderExpression
function func.Var(name) end

---turns an expression into a placeholder expression
---@param value any
---@return pl.PlaceholderExpression
function func._(value) end

---a placeholder expression for `nil`
---@type pl.PlaceholderExpression
func.Nil = nil

---creates a placeholder expression for `not value`
---@param value any
---@return pl.PlaceholderExpression
function func.Not(value) end

---creates a placeholder expression for `#value`
---@param value any
---@return pl.PlaceholderExpression
function func.Len(value) end

---creates a placeholder expression for `left and right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.And(left, right) end

---creates a placeholder expression for `left or right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Or(left, right) end

---creates a placeholder expression for `left == right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Eq(left, right) end

---creates a placeholder expression for `left < right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Lt(left, right) end

---creates a placeholder expression for `left > right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Gt(left, right) end

---creates a placeholder expression for `left <= right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Le(left, right) end

---creates a placeholder expression for `left >= right`
---@param left any
---@param right any
---@return pl.PlaceholderExpression
function func.Ge(left, right) end

---bind the first parameter of the function to a value.
---@generic T
---@param fn fun(p: T, ...: any): (...: any) -- a function of one or more arguments
---@param p T -- a value
---@return fun(...: any): (...: any) -- a function
---@nodiscard
---
---Usage:
---
---```lua
---(func.bind1(math.max, 10))(20) == math.max(10, 20)
---```
function func.bind1(fn, p) end

---@deprecated Use func.bind1 instead.
func.curry = func.bind1

---create a function which chains multiple functions.
---@param f function -- a function of at least one argument
---@param g function -- a function of at least one argument
---@param ... function -- additional functions to compose
---@return function -- a function
---@nodiscard
---
---Usage:
---
---```lua
---printf = compose(io.write, string.format)
---printf = compose(io.write, string.lower, string.format)
---```
function func.compose(f, g, ...) end

---bind the arguments of a function to given values. `func.bind(fn, v, _2)` is equivalent to `func.bind1(fn, v)`.
---@param fn function -- a function of at least one argument
---@param ... any -- values or placeholder variables
---@return function -- a function
---@nodiscard
---
---Usage:
---
---```lua
---(bind(f, func._1, a))(b) == f(a, b)
---
---(bind(f, func._2, func._1))(a, b) == f(b, a)
---```
function func.bind(fn, ...) end

return func
