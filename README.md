# Penlight Definitions

Definition files for [lunarmodules/Penlight](https://github.com/lunarmodules/Penlight) 1.13.1 to use with [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server). The annotations have been manually re-written directly from the [docs](https://lunarmodules.github.io/Penlight/index.html) and [source code](https://github.com/lunarmodules/Penlight) to be parsable by the LSP.

Some features are missing from the library simply because the LSP doesn't support them. The most pressing features are currently:

* Generic classes. Being able to create e.g. a `PLList<string>` would be wonderful.
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

The types provided by this library are, exhaustively:

* Classes, given as `PL[CLASS NAME]`. Every class is listed below: 
  * `PLDate`, `PLDateInterval`, `PLDateFormat` (from `pl.Date`) although deprecated, 
  * `PLList` (from `pl.List`), 
  * `PLMap` (from `pl.Map`), 
  * `PLMultiMap` (from `pl.MultiMap`), 
  * `PLOrderedMap` (from `pl.OrderedMap`), 
  * `PLSet` (from `pl.Set`), 
  * `PLClass`, `PLInstance` (from `pl.class`),
  * `PLComprehension` (from `pl.comprehension`)
  * `PLData`, `PLDataReadConfig`, `PLDataNewArg`, `PLDataQueryArg` (from `pl.data`)
  * `PLPlaceholderExpression` (from `pl.func`),
  * `PLInputFieldsOptions` (from `pl.input`),
  * `PLSequence` (from `pl.seq`),
  * `PLStringIOWriter`, `PLStringIOReader` (from `pl.stringio`),
  * `PLTemplate` (from `pl.stringx`), 
  * `PLCompiledTemplate`, `PLCompileTemplateOptions` (from `pl.template`), 
  * `PLTuple` (from `pl.test`),
  * `PLDeprecationOptions` (from `pl.utils`),
  * `PLXMLNode` (from `pl.xml`)
* Aliases, given as `PL[ALIAS NAME]`. Every alias is listed below:
  * `PLTokenStream`, `PLLexerFilter`, `PLLexerOptions` (from `pl.lexer`),
  * `PLBoolBinOpString`, `PLBoolOrderedBinOpString`, `PLBinOpString`, `PLUnOpString`, `PLMultiOpString`, `PLOpString` (from `pl.operator`)
  * `PLObjectWithMethodAndTwoArguments`, `PLObjectWithMethodAndOneArgument`, `PLObjectWithMethodAndNoArguments` (from `pl.seq`) which I should probably simplify,
  * `PLSipOptions` (from `pl.sip`),
  * `PLObjectWithMethod` (from `pl.tablex`)