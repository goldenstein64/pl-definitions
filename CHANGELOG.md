# Changelog

## [Unreleased]

### Added

- definitions for missing `pl.class` functions and fields
  - `pl.Class._post_init`
  - `pl.Class._class_init`
  - `pl.Class._create`
  - `pl.Class.catch`
  - `pl.Class._handler`
  - `pl.Instance.super`
  - `pl.Instance._class`
  - `pl.ClassModule.properties`
- generic definitions for container classes. These have limited functionality.
  - `pl.List`
  - `pl.Set`
  - `pl.Map`
  - `pl.OrderedMap`
  - `pl.MultiMap`
  - `pl.seq`
- operators of `pl.PlaceholderExpression`
  - these are not yet accepted as arguments to other methods
- definitions for missing `pl.func` functions and fields
  - `func.collect_values`
  - `func.PE`
  - `func.isPE`
  - `func.Var`
  - `func._`
  - `func.Nil`
  - `func.Not`
  - `func.Len`
  - `func.And`
  - `func.Or`
  - `func.Eq`
  - `func.Lt`
  - `func.Gt`
  - `func.Le`
  - `func.Ge`
- definitions for `pl.tablex.merge` with `dup` overloads
- definitions for `pl.tablex.difference` with `symm` overloads
- definition for `pl.List.default_map_with` and its alias `pl.List.default_map`
- Examples from official documentation to test against
- Links to `serpent` and `inspect` in `pl.pretty`

### Fixed

- type of `pl.app.parse_args`
- type of `pl.comprehension.new`
- type of `pl.data.read`
- type of several `pl.input` functions
  - `input.create_getter`
  - `input.numbers`
  - `input.words`
  - `input.fields`
- type of several `pl.luabalanced` functions
  - `luabalanced.match_string`
  - `luabalanced.match_bracketed`
  - `luabalanced.match_expression`
  - `luabalanced.match_namelist`
  - `luabalanced.match_explist`
  - `luabalanced.gsub`
- operators of `pl.Set`
- type of `pl.seq.printall`
- deprecation status of `pl.Date`

### Changed

- renamed `pl.data` to `pl.DataModule`

## [v1.15.0.2]

### Added

- Definition for `pl.utils.execute`

### Changed

- Documentation for some `pl.List` methods

## [v1.15.0.1]

- No changes from v1.14.0.3, just explicitly supporting Penlight v1.15.0

## [v1.14.0.3]

### Fixed

- Breaking API change from LuaLS `luadoc` module

## [v1.14.0.2]

### Added

- Add `@class` annotations for the rest of the sub-modules
- Add `@class pl` annotation: holds all sub-modules and classes accessible from `require("pl.import_into")()`
- Add string auto-completes for `tp` argument of `pl.utils.is_type(obj, tp)`

## [v1.14.0.1]

### Added

- Add changes from v1.14.0
  - `pl.func.compose` can take more than two arguments
  - `pl.path.expanduser` can fail and return `nil, string`

## [v1.13.1.4]

### Changed

- Add whitespace in a `pl.path` doc comment. Oops!
- Add comment on deprecation of `pl.func.curry`

## [v1.13.1.3]

### Fixed

- Fix type casting typos in `pl.path` and `pl.lapp`

### Changed

- Add whitespace in some doc comments for better readability

## [v1.13.1.2]

### Fixed

- Fix publishing workflow

## [v1.13.1.1]

There was an issue with deploying this release, so it can't be seen on GitHub or LuaRocks. The tag still exists though!

### Added

- Initial release on LuaRocks
