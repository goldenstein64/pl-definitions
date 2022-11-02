# Penlight Definitions

Definition files for [lunarmodules/Penlight](https://github.com/lunarmodules/Penlight) 1.13.1 to use with [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server). The annotations have been manually re-written directly from the [docs](https://lunarmodules.github.io/Penlight/index.html) and [source code](https://github.com/lunarmodules/Penlight) to be parsable by the LSP.

Some features are missing from the library simply because the LSP doesn't support them. The most pressing features are currently:

* Generic classes. Being able to create e.g. a `pl.List<string>` would be wonderful. One thing thing that is missing is annotating "function units" (as in `fun(...): ...`) and operator annotations with generic parameters.
* Setting outdated modules like `text` and `xml` as deprecated when requiring them directly.
* More robust generic function support. Variadic type packs are not very strict, and generic types often leak into the return type.

Some features are missing simply because I don't know how to lint them. The most pressing ones are in the `pl.comprehension` and `pl.func` file.

## Usage

```jsonc
// settings.json
{
  "Lua.workspace.library": [
    // path to wherever this repo was cloned to
    "path/to/this/repo",
    // e.g. on Windows, "$USERPROFILE/Documents/LuaEnvironments/penlight"

    // this library uses luafilesystem as a dependency
    "${3rd}/lfs"
  ]
}
```

For a more detailed description of how to install a library of definition files, see the LSP's [wiki](https://github.com/sumneko/lua-language-server/wiki/Libraries).

By default, this library imports everything into the global namespace. If you don't want this, delete (or move) `library/pl.lua`. In the long term, it may be useful to split this library in two: one with injected globals and one without.

## Types

The types provided by this library are, exhaustively:

* Classes, given as `pl.[CLASS NAME]`. Every class is listed below:

| Name                          | Module Source      |
| ----------------------------- | ------------------ |
| `pl.Date`                     | `pl.Date`          |
| `pl.Date.Interval`            | `pl.Date`          |
| `pl.Date.Format`              | `pl.Date`          |
| `pl.List`                     | `pl.List`          |
| `pl.Map`                      | `pl.Map`           |
| `pl.MultiMap`                 | `pl.MultiMap`      |
| `pl.OrderedMap`               | `pl.OrderedMap`    |
| `pl.Set`                      | `pl.Set`           |
| `pl.Class`                    | `pl.class`         |
| `pl.Instance`                 | `pl.class`         |
| `pl.Comprehension`            | `pl.comprehension` |
| `pl.ConfigReadConfig`         | `pl.config`        |
| `pl.Data`                     | `pl.data`          |
| `pl.Data.ReadConfig`          | `pl.data`          |
| `pl.Data.Options`             | `pl.data`          |
| `pl.Data.QueryArg`            | `pl.data`          |
| `pl.PlaceholderExpression`    | `pl.func`          |
| `pl.InputFieldsOptions`       | `pl.input`         |
| `pl.Sequence`                 | `pl.seq`           |
| `pl.StringIOWriter`           | `pl.stringio`      |
| `pl.StringIOReader`           | `pl.stringio`      |
| `pl.Template`                 | `pl.stringx`       |
| `pl.CompiledTemplate`         | `pl.template`      |
| `pl.CompiledTemplate.Options` | `pl.template`      |
| `pl.Tuple`                    | `pl.test`          |
| `pl.DeprecationOptions`       | `pl.utils`         |
| `pl.XMLNode`                  | `pl.xml`           |

* Aliases, given as `pl.[ALIAS NAME]`. Every alias is listed below:

| Name                                 | Module Source |
| ------------------------------------ | ------------- |
| `pl.TokenStream`                     | `pl.lexer`    |
| `pl.LexerFilter`                     | `pl.lexer`    |
| `pl.LexerOptions`                    | `pl.lexer`    |
| `pl.BoolBinOpString`                 | `pl.operator` |
| `pl.BoolOrderedBinOpString`          | `pl.operator` |
| `pl.BinOpString`                     | `pl.operator` |
| `pl.UnOpString`                      | `pl.operator` |
| `pl.MultiOpString`                   | `pl.operator` |
| `pl.OpString`                        | `pl.operator` |
| `pl.ObjectWithMethodAndTwoArguments` | `pl.seq`      |
| `pl.ObjectWithMethodAndOneArgument`  | `pl.seq`      |
| `pl.ObjectWithMethodAndNoArguments`  | `pl.seq`      |
| `pl.SipOptions`                      | `pl.sip`      |
| `pl.ObjectWithMethod`                | `pl.tablex`   |

I should probably simplify the `pl.seq` aliases...

Most classes have documentation of their constructor in the form of their `_init` method. The only easy way to view this would be to type `[CLASS NAME]:_init` in your editor, or doing the same with an instance. This might be changed so it is attached to the class itself, although that is undecided.