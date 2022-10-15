---@meta

local class = require("pl.class")

---# Class [`pl.List`](https://lunarmodules.github.io/Penlight/classes/pl.List.html)
---
---Python-style list class.
---
---**Please Note:** methods that change the list will return the list. This is 
---to allow for method chaining, but please note that `ls = ls:sort()` does not 
---mean that a new copy of the list is made. In-place (mutable) methods are 
---marked as returning 'the list' in this documentation.
---
---See the Guide for further [discussion](https://lunarmodules.github.io/Penlight/manual/02-arrays.md.html#Python_style_Lists)
---
---See http://www.python.org/doc/current/tut/tut.html, section 5.1
---
---**Note**: The comments before some of the functions are from the Python docs 
---and contain Python code.
---
---Written for Lua version Nick Trout 4.0; Redone for Lua 5.1, Steve Donovan.
---
---Dependencies: 
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#), 
--- [`pl.tablex`](https://lunarmodules.github.io/Penlight/libraries/pl.tablex.html#), 
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#)
---@class PLList: { [integer]: any }, PLClass
---@operator concat(PLList): PLList
---@overload fun(t?: any[]|PLList): PLList
local List = class()

---Create a new list. Can optionally pass a table; passing another instance of 
---`List` will cause a copy to be created; this will return a plain table with 
---an appropriate metatable. we pass anything which isn't a simple table to 
---`iterate()` to work out an appropriate iterator
---@param self PLList
---@param t? any[]|PLList -- An optional list-like table
function List:_init(t) end

---Create a new list. Can optionally pass a table; passing another instance of 
---`List` will cause a copy to be created; this will return a plain table with 
---an appropriate metatable. we pass anything which isn't a simple table to 
---`iterate()` to work out an appropriate iterator
---@param t? any[]|PLList -- An optional list-like table
---@return PLList -- a new List
---@nodiscard
function List.new(t) end

---Make a copy of an existing list. The difference from a plain 'copy 
---constructor' is that this returns the actual `List` subtype.
---@param self PLList
---@return PLList
---@nodiscard
function List:clone() end

---Add an item to the end of the list.
---@param self PLList
---@param i any -- An item
---@return PLList self -- the list
function List:append(i) end

---Extend the list by appending all the items in the given list.
---@param self PLList
---@param L PLList -- Another List
---@return PLList self -- the list
function List:extend(L) end

---Insert an item at a given position. `i` is the index of the element before which to insert.
---@param self PLList
---@param i integer -- index of element before which to insert
---@param x any -- A data item
---@return PLList self -- the list
function List:insert(i, x) end

---Insert an item at the beginning of the list.
---@param self PLList
---@param x any -- a data item
---@return PLList self -- the list
function List:put(x) end

---Remove an element given its index. (equivalent of Python's del s[i])
---@param self PLList
---@param i integer -- the index
---@return PLList self -- the list
function List:remove(i) end

---Remove the first item from the list whose value is given. (This is called 
---`remove` in Python; renamed to avoid confusion with `table.remove`) Return 
---`nil` if there is no such item.
---@param self PLList
---@param x any -- A data value
---@return PLList? self -- the list
function List:remove_value(x) end

---Remove the item at the given position in the list, and return it. If no 
---index is specified, `a:pop()` returns the last item in the list. The item is 
---also removed from the list.
---@param self PLList
---@param i? integer -- An index
---@return any -- the item
function List:pop(i) end

---Return the index in the list of the first item whose value is given. Return 
---`nil` if there is no such item.
---@param self PLList
---@param x any -- A data value
---@param idx? integer -- where to start search (default `1`)
---@return integer? -- the index, or nil if not found.
---@nodiscard
function List:index(x, idx) end

---Does this list contain the value?
---@param self PLList
---@param x any -- A data value
---@return boolean -- true or false
---@nodiscard
function List:contains(x) end

---Return the number of times value appears in the list.
---@param self PLList
---@param x any -- A data value
---@return integer -- number of times `x` appears
---@nodiscard
function List:count(x) end

---@param self PLList
---@param cmp? fun(a: any, b: any): boolean
---@return PLList self
---@diagnostic disable-next-line:duplicate-set-field
function List:sort(cmp) end

---Sort the items of the list, in place.
---@param self PLList
---@param cmp? PLBoolBinOpString -- an optional comparison function (default `'<'`)
---@return PLList self -- the list
---@diagnostic disable-next-line:duplicate-set-field
function List:sort(cmp) end

---@param self PLList
---@param cmp? fun(a: any, b: any): boolean
---@return PLList
---@diagnostic disable-next-line:duplicate-set-field
function List:sorted(cmp) end

---Return a sorted copy of this list.
---@param self PLList
---@param cmp? PLBoolBinOpString -- an optional comparison function (default `'<'`)
---@return PLList -- a new list
---@diagnostic disable-next-line:duplicate-set-field
function List:sorted(cmp) end

---Reverse the elements of the list, in place.
---@param self PLList
---@return PLList self -- the list
function List:reverse() end

---Return the minimum and the maximum value of the list.
---@param self PLList
---@return any min -- minimum value
---@return any max -- maximum value
function List:minmax() end

---Emulate list slicing, like `list[first:last]` in Python. If `first` or 
---`last` are negative then they are relative to the end of the list eg. 
---`slice(-2)` gives last 2 entries in a list, and `slice(-4,-2)` gives from 
----4th to -2nd
---@param self PLList
---@param first integer -- An index
---@param last integer -- An index
---@return PLList -- a new List
function List:slice(first, last) end

---Empty the list.
---@param self PLList
---@return PLList self -- the list
function List:clear() end

---Emulate Python's `range(x)` function. Included in List table for tidiness
---@param start integer -- A number
---@param finish? integer -- A number greater than start; if absent, then start is 1 and finish is start
---@param incr? integer -- an increment (may be less than 1) (default `1`)
---@return PLList -- a List from start .. finish
---
---Usage:
---
---```lua
---List.range(0, 3) == List{0, 1, 2, 3}
---
---List.range(4) = List{1, 2, 3, 4}
---
---List.range(5, 1, -1) == List{5, 4, 3, 2, 1}
---```
function List.range(start, finish, incr) end

---`list:len()` is the same as `#list`.
---@param self PLList
---@return integer
function List:len() end

---Remove a subrange of elements. equivalent to `del s[i1:i2]` in Python.
---@param self PLList
---@param i1 integer -- start of range
---@param i2 integer -- end of range
---@return PLList self -- the list
function List:chop(i1, i2) end

---Insert a sublist into a list. equivalent to `s[idx:idx] = list` in Python
---@param self PLList
---@param idx integer -- index
---@param list PLList -- list to insert
---@return PLList self -- the list
---
---Usage:
---
---```lua
---l = List{10, 20}
---l:splice(2, {21, 22})
---assert(l == List{10, 21, 22, 20})
---```
function List:splice(idx, list) end

---General slice assignment `s[i1:i2] = seq`.
---@param self PLList
---@param i1 integer -- start index
---@param i2 integer -- end index
---@param seq PLList -- a list
---@return PLList self -- the list
function List:slice_assign(i1, i2, seq) end

---Join the elements of a list using a delimiter. This method uses `tostring` 
---on all elements.
---@param self PLList
---@param delim? string -- a delimiter string, can be empty (default `""`)
---@return string -- a string
function List:join(delim) end

---Join a list of strings.
---
---Uses `table.concat` directly.
---@param self PLList
---@param delim? string -- a delimiter (default `""`)
---@return string -- a string
function List:concat(delim) end

---@param self PLList
---@param fun fun(value: any)
---@param ... any
---@diagnostic disable-next-line:duplicate-set-field
function List:foreach(fun, ...) end

---Call the function on each element of the list.
---@param self PLList
---@param fun PLOpString -- a function or callable object
---@param ... any -- optional values to pass to function
---@diagnostic disable-next-line:duplicate-set-field
function List:foreach(fun, ...) end

---Call the named method on each element of the list.
---@param self PLList
---@param name string -- the method name
---@param ... any -- optional values to pass to function
function List:foreachm(name, ...) end

---@param self PLList
---@param fun fun(value: any, arg?: any): boolean
---@param arg? any
---@return PLList
---@diagnostic disable-next-line:duplicate-set-field
function List:filter(fun, arg) end

---Create a list of all elements which match a function.
---@param self PLList
---@param fun PLBoolBinOpString -- a boolean function
---@param arg? any -- optional argument to be passed as second argument of the predicate
---@return PLList -- a new filtered list.
---@diagnostic disable-next-line:duplicate-set-field
function List:filter(fun, arg) end

---Split a string using a delimiter.
---@param s string -- the string
---@param delim? string -- the delimiter (default spaces)
---@return PLList -- a List of strings
function List.split(s, delim) end

---@param self PLList
---@param fun fun(value: any, ...: any): any
---@param ... any
---@return PLList
---@diagnostic disable-next-line:duplicate-set-field
function List:map(fun, ...) end

---Apply a function to all elements. Any extra arguments will be passed to the 
---function.
---@param self PLList
---@param fun PLOpString -- a function of at least one argument
---@param ... any -- arbitrary extra arguments.
---@return PLList -- a new list: {f(x) for x in self}
---
---Usage:
---
---```lua
---List{'one', 'two'}:map(string.upper) == {'ONE', 'TWO'}
---```
---@diagnostic disable-next-line:duplicate-set-field
function List:map(fun, ...) end

---@param self PLList
---@param fun fun(value: any, ...: any): any
---@param ... any
---@return PLList self -- the list.
---@diagnostic disable-next-line:duplicate-set-field
function List:transform(fun, ...) end

---Apply a function to all elements, in-place. Any extra arguments are passed 
---to the function.
---@param self PLList
---@param fun PLOpString -- A function that takes at least one argument
---@param ... any -- arbitrary extra arguments.
---@return PLList self -- the list.
---@diagnostic disable-next-line:duplicate-set-field
function List:transform(fun, ...) end

---@param self PLList
---@param fun fun(x: any, y: any, ...: any): any
---@param ls PLList
---@param ... any
---@return PLList
---@diagnostic disable-next-line:duplicate-set-field
function List:map2(fun, ls, ...) end


---Apply a function to elements of two lists. Any extra arguments will be 
---passed to the function
---@param self PLList
---@param fun PLBinOpString -- a function of at least two arguments
---@param ls PLList -- another list
---@param ... any -- arbitrary extra arguments.
---@return PLList -- a new list: `{fun(x, y) for x, y in zip(self, ls)}`
---@diagnostic disable-next-line:duplicate-set-field
function List:map2(fun, ls, ...) end

---apply a named method to all elements. Any extra arguments will be passed to the method.
---@param self PLList
---@param name string -- name of method
---@param ... any -- extra arguments
---@return PLList -- a new list of the results
function List:mapm(name, ...) end

---@param self PLList
---@param fun fun(memo: any, val: any): any
---@return any
---@diagnostic disable-next-line:duplicate-set-field
function List:reduce(fun) end

---'reduce' a list using a binary function.
---@param self PLList
---@param fun PLBinOpString -- a function of two arguments
---@return any -- result of the function
---@diagnostic disable-next-line:duplicate-set-field
function List:reduce(fun) end

---@param self PLList
---@param fun fun(val: any, ...: any): any
---@param ... any
---@return PLMultiMap
---@diagnostic disable-next-line:duplicate-set-field
function List:partition(fun, ...) end

---Partition a list using a classifier function. The function may return nil, 
---but this will be converted to the string key `"<nil>"`.
---@param self PLList
---@param fun PLOpString -- a function of at least one argument
---@param ... any -- will also be passed to the function
---@return PLMultiMap -- a table where the keys are the returned values, and the values are Lists of values where the function returned that key.
---@diagnostic disable-next-line:duplicate-set-field
function List:partition(fun, ...) end

---return an iterator over all values.
---@param self PLList
---@return fun(): any
function List:iter() end

---Create an iterator over a seqence. This captures the Python concept of 
---'sequence'. For tables, iterates over all values with integer indices.
---@param seq PLSequence|string|table|file*|(fun(): any) -- a sequence; a string (over characters), a table, a file object (over lines) or an iterator function
---@return fun(): any
---
---Usage:
---
---```lua
---for x in iterate {1,10,22,55} do io.write(x,',') end --> 1,10,22,55
---
---for ch in iterate 'help' do io.write(ch,' ') end --> h e l p
---```
function List.iterate(seq) end

---Concatenation operator.
---@param self PLList
---@param L PLList -- another List
---@return PLList -- a new list consisting of the list with the elements of the new list appended
function List:__concat(L) end

---Equality operator `==`. True iff all elements of two lists are equal.
---@param self PLList
---@param L PLList -- another List
---@return boolean
function List:__eq(L) end

---How our list should be rendered as a string. Uses `List:join()`.
---@param self PLList
---@return string
function List:__tostring() end

return List