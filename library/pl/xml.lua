---@meta
---# Module [`pl.xml`](https://lunarmodules.github.io/Penlight/libraries/pl.xml.html)
---
---XML LOM Utilities.
---
---This implements some useful things on [LOM](http://matthewwild.co.uk/projects/luaexpat/lom.html) 
---documents, such as returned by lxp.lom.parse. In particular, it can convert 
---LOM back into XML text, with optional pretty-printing control. It is based 
---on `stanza.lua` from [Prosody](http://hg.prosody.im/trunk/file/4621c92d2368/util/stanza.lua)
---
---```lua
---> d = xml.parse "<nodes><node id='1'>alice</node></nodes>"
---> = d
-----> <nodes><node id='1'>alice</node></nodes>
---> = xml.tostring(d,'','  ')
-----> <nodes>
----->    <node id='1'>alice</node>
-----> </nodes>
---```
---
---Can be used as a lightweight one-stop-shop for simple XML processing; a 
---simple XML parser is included but the default is to use `lxp.lom` if it can 
---be found.
---
---```plain
---Prosody IM
---Copyright (C) 2008-2010 Matthew Wild
---Copyright (C) 2008-2010 Waqas Hussain--
---classic Lua XML parser by Roberto Ierusalimschy.
---modified to output LOM format.
---http://lua-users.org/wiki/LuaXml
---```
---
---See [the Guide](https://lunarmodules.github.io/Penlight/manual/06-data.md.html#XML)
---
---Soft Dependencies: 
--- `lxp.lom` (fallback is to use basic Lua parser)
---@deprecated
local xml = {}

---create a new document node.
---@param tag string -- the tag name
---@param attr? { [string]: string } -- attributes (table of name-value pairs) (default `{}`)
---@return PLXMLNode -- the Node object
---
---Usage:
---
---```lua
---local doc = xml.new("main", { hello = "world", answer = "42" })
---print(doc)  -->  <main hello='world' answer='42'/>
---```
function xml.new(tag, attr) end

---parse an XML document. By default, this uses `lxp.lom.parse`, but falls back 
---to basic_parse, or if `use_basic` is truthy
---@param text_or_filename string -- file or string representation
---@param is_file? boolean -- whether `text_or_filename` is a file name or not (default `false`)
---@param use_basic? boolean -- do a basic parse (default `false`)
---@return PLXMLNode? -- a parsed LOM document with the document metatatables set, `nil` on error
---@return string? error -- the error can either be a file error or a parse error
function xml.parse(text_or_filename, is_file, use_basic) end

---Create a Node with a set of children (text or Nodes) and attributes.
---@param tag string -- a tag name
---@param items? PLXMLNode|string|{ [string]: string, [integer]: PLXMLNode|string} -- either a single child (text or Node), or a table where the hash part is the attributes and the list part is the children (text or Nodes).
---@return PLXMLNode -- the new Node
---
---Usage:
---
---```lua
---local doc = xml.elem("top", "hello world")                -- <top>hello world</top>
---local doc = xml.elem("main", xml.new("child"))            -- <main><child/></main>
---local doc = xml.elem("main", { "this ", "is ", "nice" })  -- <main>this is nice</main>
---local doc = xml.elem("main", { xml.new "this",
---                               xml.new "is",
---                               xml.new "nice" })          -- <main><this/><is/><nice/></main>
---local doc = xml.elem("main", { hello = "world" })         -- <main hello='world'/>
---local doc = xml.elem("main", {
---  "prefix",
---  xml.elem("child", { "this ", "is ", "nice"}),
---  "postfix",
---  attrib = "value"
---})   -- <main attrib='value'>prefix<child>this is nice</child>postfix</main>"
---```
function xml.elem(tag, items) end

---given a list of names, return a number of element constructors. If passing a 
---comma-separated string, then whitespace surrounding the values will be 
---stripped.
---
---The returned constructor functions are a shortcut to `xml.elem` where you no
---longer provide the tag-name, but only the items table.
---@param list string|string[] -- a list of names, or a comma-separated string.
---@return (fun(items: PLXMLNode|string|{ [string]: string, [integer]: PLXMLNode|string}): PLXMLNode) ... -- (multiple) constructor functions; `function(items)`. For the `items` parameter see `xml.elem`.
---
---Usage:
---
---```lua
---local new_parent, new_child = xml.tags 'mom, kid'
---doc = new_parent {new_child 'Bob', new_child 'Annie'}
----- <mom><kid>Bob</kid><kid>Annie</kid></mom>
---```
function xml.tags(list) end

---@class PLXMLNode
local PLXMLNode = {}

---Adds a document Node, at current position. This updates the last inserted 
---position to the new Node.
---@param tag string -- the tag name
---@param attrs? { [string]: string } -- attributes (table of name-value pairs) (default `{}`)
---
---Usage:
---
---```lua
---local doc = xml.new("main")
---doc:addtag("penlight", { hello = "world"})
---doc:addtag("expat")  -- added to 'penlight' since position moved
---print(doc)  -->  <main><penlight hello='world'><expat/></penlight></main>
---```
function PLXMLNode:addtag(tag, attrs) end

---Adds a text node, at current position.
---@param text string -- a string
---@return PLXMLNode self -- the current node (`self`)
---
---Usage:
---
---```lua
---local doc = xml.new("main")
---doc:text("penlight")
---doc:text("expat")
---print(doc)  -->  <main><penlightexpat</main>
---```
function PLXMLNode:text(text) end

---Moves current position up one level.
---@return PLXMLNode self -- the current node (`self`)
function PLXMLNode:up() end

---Resets current position to top level. Resets to the `self` node.
---@return PLXMLNode self -- the current node (`self`)
function PLXMLNode:reset() end

---Append a child to the currrent Node (ignoring current position).
---@param child string|PLXMLNode -- a child node (either text or a document)
---@return PLXMLNode self -- the current node (`self`)
function PLXMLNode:add_direct_child(child) end

---Append a child at the current position (without changing position).
---@param child string|PLXMLNode -- a child node (either text or a document)
---@return PLXMLNode self -- the current node (`self`)
---
---Usage:
---
---```lua
---local doc = xml.new("main")
---doc:addtag("one")
---doc:add_child(xml.new("item1"))
---doc:add_child(xml.new("item2"))
---doc:add_child(xml.new("item3"))
---print(doc)  -->  <main><one><item1/><item2/><item3/></one></main>
---```
function PLXMLNode:add_child(child) end

---Set attributes of a document node. Will add/overwite values, but will not 
---remove existing ones. Operates on the Node itself, will not take position 
---into account.
---@param t { [string]: string } -- a table containing attribute/value pairs
---@return PLXMLNode self -- the current node (`self`)
function PLXMLNode:set_attribs(t) end

---Set a single attribute of a document node. Operates on the Node itself, will 
---not take position into account.
---@param a string -- attribute
---@param v? string -- its value, pass in `nil` to delete the attribute
---@return PLXMLNode self -- the current node (`self`)
function PLXMLNode:set_attrib(a, v) end

---Gets the attributes of a document node. Operates on the Node itself, will 
---not take position into account.
---@return { [string]: string } -- table with attributes (attribute/value pairs)
---@nodiscard
function PLXMLNode:get_attribs() end

---create a substituted copy of a document
---@param data table -- a table of name-value pairs or a list of such tables
---@return PLXMLNode -- an XML document
---@nodiscard
function PLXMLNode:subst(data) end

---Return the first child with a given tag name (non-recursive).
---@param tag string -- the tag name
---@return PLXMLNode? child -- the child Node found or `nil` if not found
---@nodiscard
function PLXMLNode:child_with_name(tag) end

---Returns all elements in a document that have a given tag.
---@param tag string -- a tag name
---@param dont_recurse? boolean -- optionally only return the immediate children with this tag name (default `false`)
---@return PLXMLNode[] elements -- a list of elements found, list will be empty if none was found.
---@nodiscard
function PLXMLNode:get_elements_with_name(tag, dont_recurse) end

---Iterator over all children of a document node, including text nodes. This 
---function is not recursive, so returns only direct child nodes.
---@return fun(): PLXMLNode -- iterator that returns a single Node per iteration.
---@nodiscard
function PLXMLNode:children() end

---Return the first child element of a node, if it exists. This will skip text 
---nodes.
---@return PLXMLNode child -- first child Node or `nil` if there is none.
---@nodiscard
function PLXMLNode:first_childtag() end

---Iterator that matches tag names, and a namespace (non-recursive).
---@param tag? string -- tag names to return. Returns all tags if not provided.
---@param xmlns? string -- the namespace value ('xmlns' attribute) to return. If not provided will match all namespaces.
---@return fun(): PLXMLNode -- iterator that returns a single Node per iteration.
---@nodiscard
function PLXMLNode:matching_tags(tag, xmlns) end

---Iterator over all child tags of a document node. This will skip over text nodes.
---@return fun(): PLXMLNode -- iterator that returns a single Node per iteration.
---@nodiscard
function PLXMLNode:childtags() end

---Visit child Nodes of a node and call a function, possibly modifying the 
---document. Text elements will be skipped. This is not recursive, so only 
---direct children will be passed.
---@param callback fun(node: PLXMLNode) -- a function with signature function(node), passed the node. The element will be updated with the returned value, or deleted if it returns nil.
function PLXMLNode:maptags(callback) end

---Escapes a string for safe use in xml. Handles quotes(single+double), 
---less-than, greater-than, and ampersand.
---@param str string -- string value to escape
---@return string -- escaped string
---@nodiscard
---
---Usage:
---
---```lua
---local esc = xml.xml_escape([["'<>&]])  --> "&quot;&apos;&lt;&gt;&amp;"
---```
function xml.xml_escape(str) end

---Unescapes a string from xml. Handles quotes(single+double), less-than, 
---greater-than, and ampersand.
---@param str string -- string value to unescape
---@return string -- unescaped string
---@nodiscard
---
---Usage:
---
---```lua
---local unesc = xml.xml_escape("&quot;&apos;&lt;&gt;&amp;")  --> [["'<>&]]
---```
function xml.xml_unescape(str) end

---Function to pretty-print an XML document.
---@param doc PLXMLNode -- an XML document
---@param b_ind string|integer? -- an initial block-indent (required when `t_ind` is set)
---@param t_ind string|integer? -- an tag-indent for each level (required when `a_ind` is set)
---@param a_ind string|integer? -- if given, indent each attribute pair and put on a separate line
---@param xml_preface string|boolean? -- force prefacing with default or custom , if truthy then `&lt;?xml version='1.0'?&gt;` will be used as default.
---@nodiscard
function xml.tostring(doc, b_ind, t_ind, a_ind, xml_preface) end

---Method to pretty-print an XML document. Invokes `xml.tostring`.
---@param b_ind string|integer? -- an initial indent (required when `t_ind` is set)
---@param t_ind string|integer? -- an indent for each level (required when `a_ind` is set)
---@param a_ind string|integer? -- if given, indent each attribute pair and put on a separate line
---@param xml_preface string -- force prefacing with default or custom (default `"<?xml version='1.0'?>"`)
---@return string -- a string representation
---@nodiscard
function PLXMLNode:tostring(b_ind, t_ind, a_ind, xml_preface) end

---get the full text value of an element.
---@return string -- a single string with all text elements concatenated
---
---Usage:
---
---```lua
---local doc = xml.new("main")
---doc:text("one")
---doc:add_child(xml.elem "two")
---doc:text("three")
---
---local t = doc:get_text()    -->  "onethree"
---```
---@nodiscard
function PLXMLNode:get_text() end

---Returns a copy of a document. The `strsubst` parameter is a callback with 
---signature `function(object, kind, parent)`.
---
---Param `kind` has the following values, and parameters:
---
--- * `"*TAG"`: object is the tag-name, `parent` is the Node object. Returns the new tag name.
--- * `"*TEXT"`: object is the text-element, `parent` is the Node object. Returns the new text value.
--- * other strings not prefixed with `*`: `kind` is the attribute name, `object` is the attribute value, `parent` is the Node object. Returns the new attribute value.
---
---@param doc PLXMLNode|string -- a Node object or string (text node)
---@param strsubst? fun(object: string, kind: string, parent: PLXMLNode): string -- an optional function for handling string copying which could do substitution, etc.
---@return PLXMLNode -- copy of the document
---@nodiscard
function PLXMLNode:clone(doc, strsubst) end

---Returns a copy of a document. This is the method version of `xml.clone`.
---@param strsubst? fun(object: string, kind: string, parent: PLXMLNode): string -- an optional function for handling string copying
---@nodiscard
function PLXMLNode:filter(strsubst) end

---Compare two documents or elements. Equality is based on tag, child nodes 
---(text and tags), attributes and order of those (order only fails if both are 
---given, and not equal).
---@param t1 PLXMLNode|string -- a Node object or string (text node)
---@param t2 PLXMLNode|string -- a Node object or string (text node)
---@return boolean -- `true` when the Nodes are equal.
---@nodiscard
function xml.compare(t1, t2) end

---is this value a document element?
---@param d any -- any value
---@return boolean -- `true` if it is a table with property `tag` being a string value.
---@nodiscard
function xml.is_tag(d) end

---Calls a function recursively over Nodes in the document. Will only call on 
---tags, it will skip text nodes. The function signature for `operation` is 
---`function(tag_name, Node)`.
---@param doc PLXMLNode|string -- a Node object or string (text node)
---@param depth_first boolean -- visit child nodes first, then the current node
---@param operation fun(tag_name: string, Node: PLXMLNode) -- a function which will receive the current tag name and current node.
function xml.walk(doc, depth_first, operation) end

---Parse a well-formed HTML file as a string. Tags are case-insenstive, DOCTYPE 
---is ignored, and empty elements can be empty.
---@param s string -- the HTML
---@return PLXMLNode
---@nodiscard
function xml.parsehtml(s) end

---Parse a simple XML document using a pure Lua parser based on Robero 
---Ierusalimschy's original version.
---@param s string -- the XML document to be parsed
---@param all_text boolean -- if `true`, preserves all whitespace. Otherwise only text containing non-whitespace is included.
---@param html boolean -- if `true`, uses relaxed HTML rules for parsing
---@return PLXMLNode
---@nodiscard
function xml.basic_parse(s, all_text, html) end

---does something...
function PLXMLNode:match(pat) end

return xml