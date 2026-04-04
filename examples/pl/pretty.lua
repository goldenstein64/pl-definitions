local pretty = require("pl.pretty")

print(pretty.write({ ... }))

pretty(...)

assert(pretty.write({ "hello", nil, "world", { bye = "world", true } }) == [[
{
  "hello",
  [3] = "world",
  [4] = {
    true,
    bye = "world"
  }
}]])
