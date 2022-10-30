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
  * `pl.Date`, `pl.Date.Interval`, `pl.Date.Format` (from `pl.Date`) although deprecated, 
  * `pl.List` (from `pl.List`), 
  * `pl.Map` (from `pl.Map`), 
  * `pl.MultiMap` (from `pl.MultiMap`), 
  * `pl.OrderedMap` (from `pl.OrderedMap`), 
  * `pl.Set` (from `pl.Set`), 
  * `pl.Class`, `pl.Instance` (from `pl.class`),
  * `pl.Comprehension` (from `pl.comprehension`)
  * `pl.ConfigReadConfig` (from `pl.config`)
  * `pl.Data`, `pl.Data.ReadConfig`, `pl.Data.Options`, `pl.Data.QueryArg` (from `pl.data`)
  * `pl.PlaceholderExpression` (from `pl.func`),
  * `pl.InputFieldsOptions` (from `pl.input`),
  * `pl.Sequence` (from `pl.seq`),
  * `pl.StringIOWriter`, `pl.StringIOReader` (from `pl.stringio`),
  * `pl.Template` (from `pl.stringx`), 
  * `pl.CompiledTemplate`, `pl.CompiledTemplate.Options` (from `pl.template`), 
  * `pl.Tuple` (from `pl.test`),
  * `pl.DeprecationOptions` (from `pl.utils`),
  * `pl.XMLNode` (from `pl.xml`)
* Aliases, given as `pl.[ALIAS NAME]`. Every alias is listed below:
  * `pl.TokenStream`, `pl.LexerFilter`, `pl.LexerOptions` (from `pl.lexer`),
  * `pl.BoolBinOpString`, `pl.BoolOrderedBinOpString`, `pl.BinOpString`, `pl.UnOpString`, `pl.MultiOpString`, `pl.OpString` (from `pl.operator`)
  * `pl.ObjectWithMethodAndTwoArguments`, `pl.ObjectWithMethodAndOneArgument`, `pl.ObjectWithMethodAndNoArguments` (from `pl.seq`) which I should probably simplify,
  * `pl.SipOptions` (from `pl.sip`),
  * `pl.ObjectWithMethod` (from `pl.tablex`)

Most classes have documentation of their constructor in the form of their `_init` method. The only easy way to view this would be to type `[CLASS NAME]:_init` in your editor, or doing the same with an instance. This might be changed so it is attached to the class itself, although that is undecided.