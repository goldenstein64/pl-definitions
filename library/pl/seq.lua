---@meta
---# Module [`pl.seq`](https://lunarmodules.github.io/Penlight/libraries/pl.seq.html)
---
---Manipulating iterators as sequences.
---
---See [The Guide](https://lunarmodules.github.io/Penlight/manual/07-functional.md.html#Sequences)
---
---Dependencies:
--- [pl.utils](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#),
--- [pl.types](https://lunarmodules.github.io/Penlight/libraries/pl.types.html#),
--- [debug](https://www.lua.org/manual/5.1/manual.html#5.9)
---@class pl.seq
---@overload fun<T>(iter: T[]|(fun(): T)|pl.Sequence<T>): pl.Sequence<T>
---@overload fun<T, U>(iter: (fun(): T, U)|pl.Sequence2<T, U>): pl.Sequence2<T, U>
---@overload fun<T, U, V>(iter: (fun(): T, U, V)|pl.Sequence3<T, U, V>): pl.Sequence3<T, U, V>
---@overload fun<T, U, V, W>(iter: (fun(): T, U, V, W)|pl.Sequence4<T, U, V, W>): pl.Sequence4<T, U, V, W>
---@overload fun<T, U, V, W, X>(iter: (fun(): T, U, V, W, X)|pl.Sequence5<T, U, V, W, X>): pl.Sequence5<T, U, V, W, X>
local seq = {}

---@alias pl.seq.Iterable<T> T[] | pl.List<T> | (fun(): T) | pl.Sequence<T>
---@alias pl.seq.Iterable2<T, U> (fun(): (T, U)) | pl.Sequence2<T, U>
---@alias pl.seq.Iterable3<T, U, V> (fun(): (T, U, V)) | pl.Sequence2<T, U, V>
---@alias pl.seq.Iterable4<T, U, V, W> (fun(): (T, U, V, W)) | pl.Sequence2<T, U, V, W>
---@alias pl.seq.Iterable5<T, U, V, W, X> (fun(): (T, U, V, W, X)) | pl.Sequence2<T, U, V, W, X>

---given a number, return a `function(y)` which returns `true` if `y > x`
---@param x number | integer -- a number
---@return fun(y: number | integer): boolean
---@nodiscard
function seq.greater_than(x) end

---given a number, returns a `function(y)` which returns `true` if `y < x`
---@param x number | integer -- a number
---@return fun(y: number | integer): boolean
---@nodiscard
function seq.less_than(x) end

---given any value, return a `function(y)` which returns `true` if `y == x`
---@param x any -- a value
---@return fun(y: any): boolean
---@nodiscard
function seq.equal_to(x) end

---given a string, return a `function(s)` which matches `s` against the string.
---@param pattern string -- a string
---@return fun(s: string): (integer?, integer?, ...: any?)
---@nodiscard
---
---Usage:
---
---```lua
---seq.matching(pattern)(s) == string.find(s, pattern)
---seq{s}:matching(pattern) == string.find(s, pattern)
---```
function seq.matching(pattern) end

---sequence adaptor for a table. Note that if any generic function is passed a
---table, it will automatically use `seq.list()`
---@generic T
---@param t T[]|pl.List<T> -- a list-like table
---@return fun(): T
---@nodiscard
---
---Usage:
---
---```lua
---seq(t):sum() --> the sum of all elements of t
---```
---
---```lua
---for x in list(t) do ... end
---```
function seq.list(t) end

---return the keys of the table.
---@generic K
---@param t { [K]: any }|pl.Map<K, any> -- an arbitrary table
---@return fun(): K -- iterator over keys
---@nodiscard
function seq.keys(t) end

---@generic T
---@param iter pl.seq.Iterable<T>
---@return fun(): T
---@nodiscard
function seq.iter(iter) end

---create an iterator over a numerical range. Like the standard Python function xrange.
---@param start number -- a number
---@param finish number -- a number greater than `start`
---@return fun(): number
---@nodiscard
function seq.range(start, finish) end

---@generic T
---@param iter pl.seq.Iterable<T>
---@param condn fun(val: T): boolean
---@return integer
---@nodiscard
function seq.count(iter, condn) end

---@generic T, A
---@param iter pl.seq.Iterable<T>
---@param condn fun(val: T, arg: A): boolean
---@return integer
---@nodiscard
function seq.count(iter, condn) end

---count the number of elements in the sequence which satisfy the predicate
---@generic T, A
---@param iter pl.seq.Iterable<T> -- a sequence
---@param condn pl.BoolBinOpString -- a predicate function (must return either true or false)
---@param arg T -- optional argument to be passed to predicate as second argument.
---@return integer -- count
---@nodiscard
function seq.count(iter, condn, arg) end

---return the minimum and the maximum value of the sequence.
---@param iter pl.seq.Iterable<number> -- a sequence
---@return number -- minimum value
---@return number -- maximum value
---@nodiscard
function seq.minmax(iter) end

---return the sum and element count of the sequence.
---@param iter pl.seq.Iterable<number> -- a sequence
---@param fn? fun(val: number): number -- an optional function to apply to the values
---@return number -- the sum
---@return integer -- the element count
---@nodiscard
function seq.sum(iter, fn) end

---create a table from the sequence. (This will make the result in a `List`.)
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence
---@return pl.List<T> -- a List
---@nodiscard
---
---Usage:
---
---```lua
---seq.copy(seq.list(ls)) == ls
---
---seq.copy(seq.list {1, 2, 3}) == List{1, 2, 3}
---```
function seq.copy(iter) end

---create a table of pairs from the double-valued sequence.
---@generic K, V
---@param iter pl.seq.Iterable2<K, V> -- a double-valued sequence
---@param i1? any -- used to capture extra iterator values as with `pairs` & `ipairs`
---@param i2? any -- used to capture extra iterator values as with `pairs` & `ipairs`
---@return [K, V][] -- a list-like table
---@nodiscard
---
---Usage:
---
---```lua
---seq.copy2(ipairs{10, 20, 30}) == {{1, 10}, {2, 20}, {3, 30}}
---```
function seq.copy2(iter, i1, i2) end

---@generic T, U, V, W, X
---@param iter pl.seq.Iterable5<T, U, V, W, X>
---@return [T, U, V, W, X][]
function seq.copy_tuples(iter) end

---@generic T, U, V, W
---@param iter pl.seq.Iterable4<T, U, V, W>
---@return [T, U, V, W][]
function seq.copy_tuples(iter) end

---@generic T, U, V
---@param iter pl.seq.Iterable3<T, U, V>
---@return [T, U, V][]
function seq.copy_tuples(iter) end

---@generic T, U
---@param iter pl.seq.Iterable2<T, U>
---@return [T, U][]
function seq.copy_tuples(iter) end

---create a table of 'tuples' from a multi-valued sequence.
---A generalization of `seq.copy2`
---@generic T
---@param iter pl.seq.Iterable<T> -- a multiple-valued sequence
---@return [T][] -- a list-like table
function seq.copy_tuples(iter) end

---@param n integer
---@return fun(): number
---@nodiscard
function seq.random(n) end

---@param n integer
---@param l integer
---@return fun(): integer
---@nodiscard
function seq.random(n, l) end

---return an iterator of random numbers.
---@param n integer -- the length of the sequence
---@param l integer -- same as the first optional argument to `math.random`
---@param u integer -- same as the second optional argument to `math.random`
---@return fun(): integer -- a sequence
---@nodiscard
function seq.random(n, l, u) end

---return an iterator to the sorted elements of a sequence.
---@generic T
---@param iter fun(): T|pl.Sequence -- a sequence
---@param comp fun(a: T, b: T): boolean -- an optional comparison function (comp(x, y) is true if x < y)
---@return fun(): T
---@nodiscard
function seq.sort(iter, comp) end

---return an iterator which returns elements of two sequences.
---@generic T, U
---@param iter1 pl.seq.Iterable<T> -- a sequence
---@param iter2 pl.seq.Iterable<U> -- a sequence
---@return fun(): (T, U)
---@nodiscard
---
---Usage:
---
---```lua
---for x, y in seq.zip(ls1, ls2) do ... end
---```
function seq.zip(iter1, iter2) end

--- Makes a table where the key/values are the values and value counts of the sequence.
---
---This version works with 'hashable' values like strings and numbers.
---
---`pl.tablex.count_map` is more general.
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence
---@return pl.Map<T, integer> -- a map-like table
---@nodiscard
function seq.count_map(iter) end

---@generic T
---@param iter pl.seq.Iterable<T>
---@return fun(): T
---@nodiscard
function seq.unique(iter) end

---given a sequence, return all the unique values in that sequence.
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence
---@param returns_table true -- true if we return a table, not a sequence
---@return T[] -- a sequence or a table; defaults to a sequence.
---@nodiscard
function seq.unique(iter, returns_table) end

---print out a sequence iter with a separator.
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence
---@param sep? string -- the separator (default space)
---@param nfields? integer -- maximum number of values per line (default 7)
---@param fmt? string -- optional format string for each value
function seq.printall(iter, sep, nfields, fmt) end

-- return an iterator running over every element of two sequences (concatenation).
---@generic T1, T2
---@param iter1 pl.seq.Iterable<T1> -- a sequence
---@param iter2 pl.seq.Iterable<T2> -- a sequence
---@return fun(): T1|T2
---@nodiscard
function seq.splice(iter1, iter2) end

---@generic K, A, R
---@param fn fun(value1: K, value2: A): R
---@param iter pl.seq.Iterable2<K, A>
---@return fun(): R
---@nodiscard
function seq.map(fn, iter) end

---@generic K, A, R
---@param fn fun(value1: K, value2: A): R
---@param iter pl.seq.Iterable<K>
---@param arg A
---@return fun(): R
---@nodiscard
function seq.map(fn, iter, arg) end

---@param fn pl.UnOpString
---@param iter pl.seq.Iterable<any>
---@return fun(): any
---@nodiscard
function seq.map(fn, iter) end

---return a sequence where every element of a sequence has been transformed by
---a function. If you don't supply an argument, then the function will receive
---both values of a double-valued sequence, otherwise behaves rather like
---`tablex.map`.
---@generic K, A, R
---@param fn pl.BinOpString -- a function to apply to elements; may take two arguments
---@param iter pl.seq.Iterable<any> -- a sequence of one or two values
---@param arg unknown -- optional argument to pass to function.
---@return fun(): any
---@nodiscard
function seq.map(fn, iter, arg) end

---@generic K, A
---@param iter pl.seq.Iterable2<K, A>
---@param pred fun(value1: K, value2: A): boolean
---@return fun(): (K, A)
---@nodiscard
function seq.filter(iter, pred) end

---@generic K, A
---@param iter pl.seq.Iterable2<K, A>
---@param pred pl.BoolBinOpString
---@return fun(): (K, A)
---@nodiscard
function seq.filter(iter, pred) end

---@generic K, A
---@param iter pl.seq.Iterable<K>
---@param pred fun(value1: K, value2: A): boolean
---@param arg A
---@return fun(): K
---@nodiscard
function seq.filter(iter, pred, arg) end

---filter a sequence using a predicate function.
---@generic K, A
---@param iter pl.seq.Iterable<K> -- a sequence of one or two values
---@param pred pl.BoolBinOpString -- a boolean function; may take two arguments
---@param arg A -- optional argument to pass to function.
---@return fun(): K
---@nodiscard
function seq.filter(iter, pred, arg) end

---@generic L, T
---@param fn fun(last: L, current: T): L
---@param iter pl.seq.Iterable<T>
---@param initval L
---@return L
---@nodiscard
function seq.reduce(fn, iter, initval) end

---@generic T
---@param fn fun(last: T, current: T): T
---@param iter pl.seq.Iterable<T>
---@return T
---@nodiscard
function seq.reduce(fn, iter) end

---'reduce' a sequence using a binary function.
---@param fn pl.BinOpString -- a function of two arguments
---@param iter pl.seq.Iterable<any> -- a sequence
---@param initval? any -- optional initial value
---@return any
---@nodiscard
---
---Usage:
---
---```lua
---seq.reduce(operator.add, seq.list{1, 2, 3, 4}) == 10
---
---seq.reduce('-', {1, 2, 3, 4, 5}) == -13
---```
function seq.reduce(fn, iter, initval) end

---take the first `n` values from the sequence.
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence of one or two values
---@param n integer -- number of items to take
---@return fun(): T -- a sequence of at most `n` items
---@nodiscard
function seq.take(iter, n) end

---skip the first `n` values of a sequence
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence of one or more values
---@param n integer -- number of items to skip
---@return fun(): T
---@nodiscard
function seq.skip(iter, n) end

--- a sequence with a sequence count and the original value.
---`enum(copy(ls))` is a roundabout way of saying `ipairs(ls)`.
---@generic T1, T2
---@param iter pl.seq.Iterable2<T1, T2> -- a single or double valued sequence
---@return fun(): (integer, T1, T2) -- sequence of (i, v), i = 1..n and v is from iter.
---@nodiscard
function seq.enum(iter) end

---@alias pl.ObjectWithMethodAndTwoArguments<Method, A1, A2, R> { [Method]: fun(self: pl.ObjectWithMethodAndTwoArguments<Method, A1, A2, R>, arg1: A1, arg2: A2, ...: any): R }
---@alias pl.ObjectWithMethodAndOneArgument<Method, A, R> { [Method]: fun(self: pl.ObjectWithMethodAndOneArgument<Method, A, R>, arg1: A): R }
---@alias pl.ObjectWithMethodAndNoArguments<Method, R> { [Method]: fun(self: pl.ObjectWithMethodAndNoArguments<Method, R>): R }

---map using a named method over a sequence.
---@generic Method, A1, A2, R
---@param iter pl.seq.Iterable<pl.ObjectWithMethodAndTwoArguments<Method, A1, A2, R>> -- a sequence
---@param name Method -- the method name
---@param arg1 A1 -- optional first extra argument
---@param arg2 A2 -- optional second extra argument
---@return fun(): R
---@nodiscard
function seq.mapmethod(iter, name, arg1, arg2) end

---@generic S, A
---@param iter pl.seq.Iterable<pl.ObjectWithMethodAndOneArgument<S, A>>
---@param name S
---@param arg1 A
---@return fun(): (...: any)
---@nodiscard
function seq.mapmethod(iter, name, arg1) end

---@generic S
---@param iter pl.seq.Iterable<pl.ObjectWithMethodAndNoArguments<S>>
---@param name S
---@return fun(): (...: any)
---@nodiscard
function seq.mapmethod(iter, name) end

---returns a sequence of (last, current) values from another sequence.
---This will return S(i-1), S(i) if given S(i)
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence
---@nodiscard
---@return fun(): (T, T)
function seq.last(iter) end

---@generic T1, T2, T3
---@param iter pl.seq.Iterable3<T1, T2, T3>
---@param fn fun(v1: T1, v2: T2, v3: T3)
function seq.foreach(iter, fn) end

---@generic T1, T2
---@param iter pl.seq.Iterable2<T1, T2>
---@param fn fun(v1: T1, v2: T2)
function seq.foreach(iter, fn) end

---create a wrapped iterator over all lines in the file.
---@param f file*|string -- either a filename, file-like object, or `'STDIN'` (for standard input)
---@param ... readmode -- for Lua 5.2 only, optional format specifiers, as in `io.read`.
function seq.lines(f, ...) end

---call the function on each element of the sequence.
---@generic T
---@param iter pl.seq.Iterable<T> -- a sequence with up to 3 values
---@param fn fun(v: T) -- a function
function seq.foreach(iter, fn) end

---makes `seq` functions available as methods on raw functions without calling
---`seq()` on them.
---
---Usage:
---
---```lua
---local i = 0
---local function f()
---  i = i + 1
---  if i <= 10 then
---    return i
---  else
---    return nil
---  end
---end
---
---seq.import()
---
----- raw functions can use `seq` methods
---f:printall() --> 1 2 3 4 5 6 7 8 9 10
---```
function seq.import() end

---@class pl.Sequence<T>
---@field iter fun(...: any): T
---@overload fun(...: any): T
local Sequence = {}

---@class pl.Sequence2<T, U> : pl.Sequence<T>
---@field iter fun(...: any): (T, U)
---@overload fun(...: any): (T, U)
local Sequence2 = {}

---@class pl.Sequence3<T, U, V> : pl.Sequence2<T, U>
---@field iter fun(...: any): (T, U, V)
---@overload fun(...: any): (T, U, V)
local Sequence3 = {}

---@class pl.Sequence4<T, U, V, W> : pl.Sequence3<T, U, V>
---@field iter fun(...: any): (T, U, V, W)
---@overload fun(...: any): (T, U, V, W)
local Sequence4 = {}

---@class pl.Sequence5<T, U, V, W, X> : pl.Sequence4<T, U, V, W>
---@field iter fun(...: any): (T, U, V, W, X)
---@overload fun(...: any): (T, U, V, W, X)
local Sequence5 = {}

---count the number of elements in the sequence which satisfy the predicate
---@generic T, A
---@param self pl.Sequence<T>
---@param condn pl.BoolBinOpString|fun(val: T, arg: A): boolean -- a predicate function (must return either true or false)
---@param arg A -- optional argument to be passed to predicate as second argument.
---@return integer -- count
---@nodiscard
function Sequence:count(condn, arg) end

---@generic T
---@param self pl.Sequence<T>
---@param condn fun(val: T): boolean
---@return integer
---@nodiscard
function Sequence:count(condn) end

---return the minimum and the maximum value of the sequence.
---@generic T: number
---@param self pl.Sequence<T>
---@return number -- minimum value
---@return number -- maximum value
---@nodiscard
function Sequence:minmax() end

---return the sum and element count of the sequence.
---@generic T: number
---@param self pl.Sequence<T>
---@param fn? fun(val: T): number -- an optional function to apply to the values
---@return number -- the sum
---@return integer -- the element count
---@nodiscard
function Sequence:sum(fn) end

--- create a table from the sequence. (This will make the result in a `List`.)
---@generic T
---@param self pl.Sequence<T>
---@return pl.List<T> -- a List
---@nodiscard
---
---Usage:
---
---```lua
---seq.copy(seq.list(ls)) == ls
---
---seq.copy(seq.list {1, 2, 3}) == List{1, 2, 3}
---```
function Sequence:copy() end

---create a table of pairs from the double-valued sequence.
---@generic K, V, I1, I2
---@param self pl.Sequence2<K, V>
---@param i1? I1 -- used to capture extra iterator values as with `pairs` & `ipairs`
---@param i2? I2 -- used to capture extra iterator values as with `pairs` & `ipairs`
---@return [K, V][] -- a list-like table
---@nodiscard
---
---Usage:
---
---```lua
---seq(ipairs{}):copy2({10, 20, 30}, 0) == {{1, 10}, {2, 20}, {3, 30}}
---```
function Sequence2:copy2(i1, i2) end

---@generic T
---@param self pl.Sequence<T>
---@return [T][]
---@nodiscard
function Sequence:copy_tuples() end

---@generic T, U
---@param self pl.Sequence2<T, U>
---@return [T, U][]
---@nodiscard
function Sequence2:copy_tuples() end

---@generic T, U, V
---@param self pl.Sequence3<T, U, V>
---@return [T, U, V][]
---@nodiscard
function Sequence3:copy_tuples() end

---@generic T, U, V, W
---@param self pl.Sequence4<T, U, V, W>
---@return [T, U, V, W][]
---@nodiscard
function Sequence4:copy_tuples() end

---create a table of 'tuples' from a multi-valued sequence.
---A generalization of `seq.copy2`
---@generic T, U, V, W, X
---@param self pl.Sequence5<T, U, V, W, X>
---@return [T, U, V, W, X][] -- a list-like table
---@nodiscard
function Sequence5:copy_tuples() end

---return an iterator to the sorted elements of a sequence.
---@generic T
---@param self pl.Sequence<T>
---@param comp fun(a: T, b: T): boolean -- an optional comparison function (comp(x, y) is true if x < y)
---@return pl.Sequence<T>
---@nodiscard
function Sequence:sort(comp) end

---return an iterator which returns elements of two sequences.
---@generic T, U
---@param self pl.Sequence<T>
---@param iter2 U[]|fun(): U|pl.Sequence<U> -- a sequence
---@return pl.Sequence2<T, U>
---@nodiscard
---
---Usage:
---
---```lua
---for x, y in seq.zip(ls1, ls2) do ... end
---```
function Sequence:zip(iter2) end

--- Makes a table where the key/values are the values and value counts of the sequence.
---
---This version works with 'hashable' values like strings and numbers.
---
---`pl.tablex.count_map` is more general.
---@generic T
---@param self pl.Sequence<T> -- a sequence
---@return pl.Map<T, integer> -- a map-like table
---@nodiscard
function Sequence:count_map() end

---@generic T
---@param self pl.Sequence<T>
---@param returns_table? false
---@return pl.Sequence<T>
---@nodiscard
function Sequence:unique(returns_table) end

---given a sequence, return all the unique values in that sequence.
---@generic T
---@param self pl.Sequence<T> -- a sequence
---@param returns_table true -- true if we return a table, not a sequence
---@return T[] -- a sequence or a table; defaults to a sequence.
---@nodiscard
function Sequence:unique(returns_table) end

---print out a sequence iter with a separator.
---@generic T
---@param self pl.Sequence -- a sequence
---@param sep? string -- the separator (default space)
---@param nfields? integer -- maximum number of values per line (default 7)
---@param fmt? string -- optional format string for each value
function Sequence:printall(sep, nfields, fmt) end

-- return an iterator running over every element of two sequences (concatenation).
---@generic T, T2
---@param self pl.Sequence<T>
---@param iter2 (fun(): T2)|pl.Sequence<T2> -- a sequence
---@return pl.Sequence<T | T2>
---@nodiscard
function Sequence:splice(iter2) end

---@generic T, A, R
---@param self pl.Sequence<T>
---@param fn fun(value: T): R
---@return pl.Sequence<R>
function Sequence2:map(fn) end

---return a sequence where every element of a sequence has been transformed by
---a function. If you don't supply an argument, then the function will receive
---both values of a double-valued sequence, otherwise behaves rather like
---`tablex.map`.
---@generic T, U, R
---@param self pl.Sequence2<T, U>
---@param fn fun(value1: T, value2: U): R
---@return pl.Sequence<R>
---@nodiscard
function Sequence:map(fn) end

---@param self pl.Sequence<any>
---@param fn pl.BinOpString|pl.UnOpString
---@param arg any
---@return pl.Sequence<any>
---@nodiscard
function Sequence:map(fn, arg) end

---return a sequence where every element of a sequence has been transformed by
---a function. If you don't supply an argument, then the function will receive
---both values of a double-valued sequence, otherwise behaves rather like
---`tablex.map`.
---@generic T, A, R
---@param self pl.Sequence<T>
---@param fn fun(value1: T, value2: A): R -- a function to apply to elements; may take two arguments
---@param arg A -- optional argument to pass to function.
---@return pl.Sequence<R>
---@nodiscard
function Sequence:map(fn, arg) end

---@param self pl.Sequence<any>
---@param fn pl.BinOpString|pl.UnOpString
---@return pl.Sequence<any>
---@nodiscard
function Sequence:map(fn) end

---@generic T, U
---@param self pl.Sequence2<T, U>
---@param pred fun(value1: T, value2: U): boolean
---@return pl.Sequence2<T, U>
---@nodiscard
function Sequence2:filter(pred) end

---@generic T
---@param self pl.Sequence<T>
---@param pred fun(value1: T): boolean
---@return pl.Sequence2<T>
---@nodiscard
function Sequence:filter(pred) end

---@generic T
---@param self pl.Sequence<T>
---@param pred pl.BoolBinOpString
---@param arg any
---@return pl.Sequence<T>
---@nodiscard
function Sequence:filter(pred, arg) end

---filter a sequence using a predicate function.
---@generic T, A
---@param self pl.Sequence<T>
---@param pred fun(value1: T, value2: A): boolean -- a boolean function; may take two arguments
---@param arg A -- optional argument to pass to function.
---@return pl.Sequence<T>
---@nodiscard
function Sequence:filter(pred, arg) end

---@generic T, A
---@param self pl.Sequence<T>
---@param pred pl.BoolBinOpString
---@return pl.Sequence<T>
---@nodiscard
function Sequence:filter(pred) end

---@param self pl.Sequence<any>
---@param fn pl.BinOpString
---@param initval any
---@return any
---@nodiscard
function Sequence:reduce(fn, initval) end

---@generic T
---@param self pl.Sequence<T>
---@param fn fun(last: T, current: T): T
---@return T
---@nodiscard
function Sequence:reduce(fn) end

---@generic T
---@param self pl.Sequence
---@param fn pl.BinOpString
---@return T
---@nodiscard
function Sequence:reduce(fn) end

---'reduce' a sequence using a binary function.
---@generic L, T
---@param self pl.Sequence<T>
---@param fn fun(last: L, current: T): L -- a function of two arguments
---@param initval L -- optional initial value
---@return L
---@nodiscard
---
---Usage:
---
---```lua
---seq.reduce(operator.add, seq.list{1, 2, 3, 4}) == 10
---
---seq.reduce('-', {1, 2, 3, 4, 5}) == -13
---```
function Sequence:reduce(fn, initval) end

---@generic T, U
---@param self pl.Sequence2<T, U>
---@param n integer
---@return pl.Sequence2<T, U>
---@nodiscard
function Sequence2:take(n) end
---@generic T, U, V
---@param self pl.Sequence3<T, U, V>
---@param n integer
---@return pl.Sequence3<T, U, V>
---@nodiscard
function Sequence3:take(n) end
---@generic T, U, V, W
---@param self pl.Sequence4<T, U, V, W>
---@param n integer
---@return pl.Sequence4<T, U, V, W>
---@nodiscard
function Sequence4:take(n) end

---@generic T, U, V, W, X
---@param self pl.Sequence5<T, U, V, W, X>
---@param n integer
---@return pl.Sequence5<T, U, V, W, X>
---@nodiscard
function Sequence5:take(n) end

---take the first `n` values from the sequence.
---@generic T
---@param self pl.Sequence<T>
---@param n integer -- number of items to take
---@return pl.Sequence<T>
---@nodiscard
function Sequence:take(n) end

---@generic T, U
---@param self pl.Sequence2<T, U>
---@param n integer
---@return self self
---@nodiscard
function Sequence2:skip(n) end

---@generic T, U, V
---@param self pl.Sequence3<T, U, V>
---@param n integer
---@return self self
---@nodiscard
function Sequence3:skip(n) end

---@generic T, U, V, W
---@param self pl.Sequence4<T, U, V, W>
---@param n integer
---@return self self
---@nodiscard
function Sequence4:skip(n) end

---@generic T, U, V, W, X
---@param self pl.Sequence5<T, U, V, W, X>
---@param n integer
---@return self self
---@nodiscard
function Sequence5:skip(n) end

---skip the first `n` values of a sequence
---@generic T
---@param self pl.Sequence<T>
---@param n integer -- number of items to skip
---@return pl.Sequence<T>
---@nodiscard
function Sequence:skip(n) end

---@generic T, U
---@param self pl.Sequence2<T, U>
---@return pl.Sequence3<integer, T, U>
---@nodiscard
function Sequence2:enum() end

--- a sequence with a sequence count and the original value.
---`enum(copy(ls))` is a roundabout way of saying `ipairs(ls)`.
---@generic T
---@param self pl.Sequence<T>
---@return pl.Sequence2<integer, T>
---@nodiscard
function Sequence:enum() end

---map using a named method over a sequence.
---@generic Method, A1, A2, R
---@param self pl.Sequence<pl.ObjectWithMethodAndNoArguments<Method, A1, A2, R>>
---@param name Method -- the method name
---@param arg1 A1 -- optional first extra argument
---@param arg2 A2 -- optional second extra argument
---@return pl.Sequence<R>
---@nodiscard
function Sequence:mapmethod(name, arg1, arg2) end

---@generic Method, A, R
---@param self pl.Sequence<pl.ObjectWithMethodAndOneArgument<Method, A, R>>
---@param name Method
---@param arg A
---@return pl.Sequence<R>
---@nodiscard
function Sequence:mapmethod(name, arg) end

---@generic Method, R
---@param self pl.Sequence<pl.ObjectWithMethodAndNoArguments<Method, R>>
---@param name Method
---@return pl.Sequence<R>
---@nodiscard
function Sequence:mapmethod(name) end

---returns a sequence of (last, current) values from another sequence.
---This will return S(i-1), S(i) if given S(i)
---@generic T
---@param self pl.Sequence<T>
---@return pl.Sequence2<T, T>
---@nodiscard
function Sequence:last() end

---@generic T1, T2, T3
---@param self pl.Sequence3<T1, T2, T3>
---@param fn fun(v1: T1, v2: T2, v3: T3)
function Sequence:foreach(fn) end

---@generic T1, T2
---@param self pl.Sequence2<T1, T2>
---@param fn fun(v1: T1, v2: T2)
function Sequence:foreach(fn) end

---call the function on each element of the sequence.
---@generic T
---@param self pl.Sequence<T>
---@param fn fun(v: T) -- a function
function Sequence:foreach(fn) end

return seq
