# Penlight Definitions

Definition files for [lunarmodules/Penlight](https://github.com/lunarmodules/Penlight) 1.13.1 to use with [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server). The annotations have been manually re-written directly from the [docs](https://lunarmodules.github.io/Penlight/index.html) and [source code](https://github.com/lunarmodules/Penlight) to be parsable by the LSP.

Some features are missing from the library simply because the LSP doesn't support them. The most pressing features are currently:

- Generic classes. Being able to create e.g. a `pl.List<string>` would be wonderful. One thing that is missing is annotating "function units" (as in `fun(...): ...`) and operator annotations with generic parameters.
- Setting outdated modules like `text` and `xml` as deprecated when requiring them directly.
- More robust generic function support. Variadic type packs are not very strict, and generic types often leak into the return type.

Some features are missing simply because I don't know how to lint them. The most pressing ones are in the `pl.comprehension` and `pl.func` file.

## Usage

Definition files can be installed via [luarocks](https://luarocks.org):

```sh
luarocks install lls-addon-penlight
```

or by using the [addon manager](https://github.com/LuaLS/lua-language-server/wiki/Addons#vs-code-addon-manager), under "Penlight".

For manual installation, add these settings to your `settings.json` file.

```jsonc
// settings.json
{
  "Lua.workspace.library": [
    // path to wherever this repo was cloned to
    "path/to/this/repo",
    // e.g. on Windows, "$USERPROFILE/Documents/LuaEnvironments/penlight"

    // this library uses luafilesystem as a dependency
    // See: https://github.com/goldenstein64/lls-addon-luafilesystem
    "path/to/lls-addon-luafilesystem",
  ],
  "Lua.runtime.plugin": "path/to/this/repo/plugin.lua",
}
```

The plugin is used to generate global imports when it finds `---@module "pl"` or `require("pl")` in any file. This works for most if not all outlandish representations of the syntax like `--[=[@module [[pl]]]=]`.

The plugin doesn't do anything special for requires that execute conditionally, e.g.

```lua
-- this injects globals
if false then
  require("pl")
end

-- this doesn't inject globals
local plString = "pl"
require(plString)
```

For a more detailed description of how to install a library of definition files, see the LSP's [wiki](https://github.com/sumneko/lua-language-server/wiki/Libraries).

## Types

The types provided by this library are, exhaustively:

- Classes, given as `pl.[CLASS NAME]`. Every class is listed below:

  | Name                             | Module Source      |
  | -------------------------------- | ------------------ |
  | `pl`                             | `pl.init`          |
  | `pl.app`                         | `pl.app`           |
  | `pl.array2d`                     | `pl.array2d`       |
  | `pl.ClassModule`                 | `pl.class`         |
  | `pl.compat`                      | `pl.compat`        |
  | `pl.config`                      | `pl.config`        |
  | `pl.DataModule`                  | `pl.data`          |
  | `pl.dir`                         | `pl.dir`           |
  | `pl.file`                        | `pl.file`          |
  | `pl.func`                        | `pl.func`          |
  | `pl.input`                       | `pl.input`         |
  | `pl.lapp`                        | `pl.lapp`          |
  | `pl.lexer`                       | `pl.lexer`         |
  | `pl.luabalanced`                 | `pl.luabalanced`   |
  | `pl.operator`                    | `pl.operator`      |
  | `pl.path`                        | `pl.path`          |
  | `pl.permute`                     | `pl.permute`       |
  | `pl.pretty`                      | `pl.pretty`        |
  | `pl.seq`                         | `pl.seq`           |
  | `pl.sip`                         | `pl.sip`           |
  | `pl.strict`                      | `pl.strict`        |
  | `pl.stringio`                    | `pl.stringio`      |
  | `pl.stringx`                     | `pl.stringx`       |
  | `pl.tablex`                      | `pl.tablex`        |
  | `pl.template`                    | `pl.template`      |
  | `pl.test`                        | `pl.test`          |
  | `pl.text`                        | `pl.text`          |
  | `pl.types`                       | `pl.types`         |
  | `pl.url`                         | `pl.url`           |
  | `pl.utils`                       | `pl.utils`         |
  | `pl.xml`                         | `pl.xml`           |
  | `pl.ConfigReadConfig`            | `pl.config`        |
  | `pl.Data.ReadConfig`             | `pl.data`          |
  | `pl.Data.Options`                | `pl.data`          |
  | `pl.Data.QueryArg`               | `pl.data`          |
  | `pl.DateBase`                    | `pl.Date`          |
  | `pl.DateClass`                   | `pl.Date`          |
  | `pl.Date`                        | `pl.Date`          |
  | `pl.Date.IntervalBase`           | `pl.Date`          |
  | `pl.Date.IntervalClass`          | `pl.Date`          |
  | `pl.Date.Interval`               | `pl.Date`          |
  | `pl.Date.FormatBase`             | `pl.Date`          |
  | `pl.Date.FormatClass`            | `pl.Date`          |
  | `pl.Date.Format`                 | `pl.Date`          |
  | `pl.ListBase`                    | `pl.List`          |
  | `pl.ListClass`                   | `pl.List`          |
  | `pl.List<T>`                     | `pl.List`          |
  | `pl.MapBase`                     | `pl.Map`           |
  | `pl.MapClass`                    | `pl.Map`           |
  | `pl.Map<K, V>`                   | `pl.Map`           |
  | `pl.MultiMapBase`                | `pl.MultiMap`      |
  | `pl.MultiMapClass`               | `pl.MultiMap`      |
  | `pl.MultiMap<K, V>`              | `pl.MultiMap`      |
  | `pl.OrderedMapBase`              | `pl.OrderedMap`    |
  | `pl.OrderedMapClass`             | `pl.OrderedMap`    |
  | `pl.OrderedMap<K, V>`            | `pl.OrderedMap`    |
  | `pl.SetClass`                    | `pl.Set`           |
  | `pl.Set<T>`                      | `pl.Set`           |
  | `pl.Class`                       | `pl.class`         |
  | `pl.Instance`                    | `pl.class`         |
  | `pl.Comprehension`               | `pl.comprehension` |
  | `pl.ConfigReadConfig`            | `pl.config`        |
  | `pl.Data`                        | `pl.data`          |
  | `pl.Data.ReadConfig`             | `pl.data`          |
  | `pl.Data.Options`                | `pl.data`          |
  | `pl.Data.QueryArg`               | `pl.data`          |
  | `pl.PlaceholderExpressionFields` | `pl.func`          |
  | `pl.PlaceholderExpression`       | `pl.func`          |
  | `pl.InputFieldsOptions`          | `pl.input`         |
  | `pl.Sequence<T>`                 | `pl.seq`           |
  | `pl.Sequence2<T, U>`             | `pl.seq`           |
  | `pl.Sequence3<T, U, V>`          | `pl.seq`           |
  | `pl.Sequence4<T, U, V, W>`       | `pl.seq`           |
  | `pl.Sequence5<T, U, V, W, X>`    | `pl.seq`           |
  | `pl.StringIOWriter`              | `pl.stringio`      |
  | `pl.StringIOReader`              | `pl.stringio`      |
  | `pl.Template`                    | `pl.stringx`       |
  | `pl.CompiledTemplate`            | `pl.template`      |
  | `pl.CompiledTemplate.Options`    | `pl.template`      |
  | `pl.Tuple`                       | `pl.test`          |
  | `pl.DeprecationOptions`          | `pl.utils`         |
  | `pl.XMLNode`                     | `pl.xml`           |

  There is also a `@class` annotation for each module and `pl`.

- Aliases, given as `pl.[ALIAS NAME]`. Every alias is listed below:

  | Name                                                    | Module Source |
  | ------------------------------------------------------- | ------------- |
  | `pl.TokenStream`                                        | `pl.lexer`    |
  | `pl.LexerFilter`                                        | `pl.lexer`    |
  | `pl.LexerOptions`                                       | `pl.lexer`    |
  | `pl.BoolBinOpString`                                    | `pl.operator` |
  | `pl.BoolOrderedBinOpString`                             | `pl.operator` |
  | `pl.BinOpString`                                        | `pl.operator` |
  | `pl.UnOpString`                                         | `pl.operator` |
  | `pl.MultiOpString`                                      | `pl.operator` |
  | `pl.OpString`                                           | `pl.operator` |
  | `pl.seq.Iterable<T>`                                    | `pl.seq`      |
  | `pl.seq.Iterable2<T, U>`                                | `pl.seq`      |
  | `pl.seq.Iterable3<T, U, V>`                             | `pl.seq`      |
  | `pl.seq.Iterable4<T, U, V, W>`                          | `pl.seq`      |
  | `pl.seq.Iterable5<T, U, V, W, X>`                       | `pl.seq`      |
  | `pl.ObjectWithMethodAndTwoArguments<Method, A1, A2, R>` | `pl.seq`      |
  | `pl.ObjectWithMethodAndOneArgument<Method, A, R>`       | `pl.seq`      |
  | `pl.ObjectWithMethodAndNoArguments<Method, R>`          | `pl.seq`      |
  | `pl.SipOptions`                                         | `pl.sip`      |

  I should probably simplify the `pl.seq` aliases...

Most classes have documentation of their constructor in the form of their `_init` method. The only easy way to view this would be to type `[CLASS NAME]:_init` in your editor, or doing the same with an instance. This might be changed so it is attached to the class itself, although that is undecided.
