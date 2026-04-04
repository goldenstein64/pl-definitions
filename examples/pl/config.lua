local test_config = [[
# test.config
# Read timeout in seconds
read.timeout=10
# Write timeout in seconds
write.timeout=5
#acceptable ports
ports = 1002,1003,1004
]]
do
	local test_config_file = assert(io.open("test.config", "w"))
	assert(test_config_file:write(test_config))
	assert(test_config_file:close())
end

local config = require("pl.config") ---@type pl.config
local pretty = require("pl.pretty") ---@type pl.pretty
local t = assert(config.read("test.config"))

assert(pretty.write(t) == [[
{
  ports = {
    1002,
    1003,
    1004
  },
  write_timeout = 5,
  read_timeout = 10
}]])
