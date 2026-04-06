local xml = require("pl.xml")
local pretty = require("pl.pretty")

local intro = xml.new("intro", { title = "Introduction", length = "297", width = "210" })
	:addtag("hook", { title = "Appeal" })
	:text("some hook text")
	:up()
	:addtag("blurb", { title = "Structure" })
	:text("some blurb text")
	:up()
	:addtag("call-to-action", { title = "Purpose" })
	:text("some call to action text")

print(intro)
-- it doesn't actually get prettified like this, this is just for
-- readability.
--[[-->
<intro title='Introduction' length='297' width='210'>
  <hook title='Appeal'>
    some hook text
  </topic>
  <blurb title='Structure'>
    some blurb text
  </topic>
  <call-to-action title='Purpose'>
    some call to action text
  </topic>
</intro>
]]

local match, ok = intro:match("<intro>{{<tag- title='$title'>$text</tag->}}</intro>")
assert(ok, "match not found")

print(pretty.write(match))
--[[-->
{
  {
    tag = "hook",
    text = "some hook text",
    title = "Appeal"
  },
  {
    tag = "blurb",
    text = "some blurb text",
    title = "Structure"
  },
  {
    tag = "call-to-action",
    text = "some call to action text",
    title = "Purpose"
  }
}
]]

---@param match any
---@param s boolean
local function write_match(match, s)
	assert(s, "match not found")
	print(pretty.write(match))
end

local parent = xml.new("parent"):addtag("node", { attr = "attr_value", attr2 = "attr_value2" })

write_match(parent:match("<parent>{{<node attr='$my_key' />}}</parent>"))
--[[-->
{
  {
    my_key = "attr_value"
  }
}
]]

write_match(parent:match("<parent>{{<node attr='$0' />}}</parent>"))
--[[-->
{
  "attr_value"
}
]]

write_match(parent:match("<parent>{{<node attr='$_' attr2='$key2' />}}</parent>"))
--[[-->
{
  attr_value = {
    key2 = "attr_value2"
  }
}
]]

write_match(parent:match("<parent>{{<node attr='$_' attr2='$0' />}}</parent>"))
--[[-->
{
  attr_value = "attr_value2"
}
]]

write_match(parent:match("<parent>{{<_- attr2='$0' />}}</parent>"))
--[[-->
{
  node = "attr_value2"
}
]]
