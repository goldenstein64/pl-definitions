# PenLight Definitions

Definition files for [lunarmodules/Penlight](https://github.com/lunarmodules/Penlight) to use with [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server).

## Usage

```json
// settings.json
{
	"Lua.workspace.library": [
		// path to wherever this repo was cloned to
		"path/to/this/repo",

		// this library uses luafilesystem as a dependency
		"${3rd}/lfs"
	]
}
```

For a more detailed description of how to install a library of definition files, see the [wiki](https://github.com/sumneko/lua-language-server/wiki/Libraries).

By default, this library imports everything into the global namespace. If you don't want this, delete (or move) `library/pl/init.lua`.