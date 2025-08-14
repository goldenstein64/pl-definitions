rockspec_format = "3.0"
package = "lls-addon-penlight"
version = "release-1"

source = {
	url = "git+https://github.com/goldenstein64/pl-definitions",
}

description = {
	summary = "LuaLS type definitions for Penlight",
	license = "MIT",
	homepage = "https://github.com/goldenstein64/pl-definitions",
}

dependencies = {
	"lls-addon-luafilesystem",
}

build = {
	type = "lls-addon",
}
