---@meta
---# Module [`pl.dir`](https://lunarmodules.github.io/Penlight/libraries/pl.dir.html)
---
---Listing files in directories and creating/removing directory paths.
---
---Dependencies:
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html),
--- [`pl.path`](https://lunarmodules.github.io/Penlight/libraries/pl.path.html)
---
---Soft Dependencies: `alien`, `ffi` (either are used on Windows for copying/moving files)
local dir = {}

---Test whether a file name matches a shell pattern. Both parameters are
---case-normalized if operating system is case-insensitive.
---@param filename string -- A file name.
---@param pattern string -- A shell pattern. The only special characters are '\*' and '?': '\*' matches any sequence of characters and '?' matches any single character.
---@return boolean
---@nodiscard
function dir.fnmatch(filename, pattern) end

---Return a list of all file names within an array which match a pattern.
---@param filenames string[] -- An array containing file names.
---@param pattern string -- A shell pattern (see `dir.fnmatch`).
---@return pl.List -- List of matching file names.
---@nodiscard
function dir.filter(filenames, pattern) end

---return a list of all files in a directory which match a shell pattern.
---@param dirname? string -- A directory. (default `'.'`)
---@param mask? string -- A shell pattern (see `dir.fnmatch`). If not given, all files are returned. (optional)
---@return pl.List -- list of files
---@nodiscard
function dir.getfiles(dirname, mask) end

---return a list of all subdirectories of the directory.
---@param dirname? string -- A directory. (default `'.'`)
---@return pl.List -- a list of directories
---@nodiscard
---
---Raises: dir must be a valid directory
function dir.getdirectories(dirname) end

---copy a file.
---@param src string -- source file
---@param dest string -- destination file or directory
---@param flag boolean? -- true if you want to force the copy (default)
---@return boolean -- operation succeeded
function dir.copyfile(src, dest, flag) end

---move a file.
---@param src string -- source file
---@param dest string -- destination file or directory
---@return boolean -- operation succeeded
function dir.movefile(src, dest) end

---return an iterator which walks through a directory tree starting at root.
---The iterator returns `(root, dirs, files)`
---
---Note that dirs and files are lists of names (i.e. you must say
---`path.join(root, d)` to get the actual full path) If `bottom_up` is `false`
---(or not present), then the entries at the current level are returned before
---we go deeper. This means that you can modify the returned list of directories
---before continuing. This is a clone of `os.walk` from the Python libraries.
---@param root string -- A starting directory
---@param bottom_up? boolean -- `false` if we start listing entries immediately. (default)
---@param follow_links? boolean -- follow symbolic links (default `false`)
---@return fun(): string -- an iterator returning root,dirs,files
---@nodiscard
---
---Raises: `root` must be a directory
function dir.walk(root, bottom_up, follow_links) end

---Remove a whole directory tree.
---Symlinks in the tree will be deleted without following them.
---@param fullpath string -- A directory path (must be an actual directory, not a symlink)
---@return true?, string? -- `true` on success, `nil + errormsg` on failure
---
---Raises: `fullpath` must be a string
function dir.rmtree(fullpath) end

---Create a directory path.
---This will create subdirectories as necessary!
---@param p string A directory path
---@return true?, string? -- `true` on success, `nil + errormsg` on failure
---
---Raises: failure to create
function dir.makepath(p) end

---Clone a directory tree.
---Will always try to create a new directory structure
---if necessary.
---@param path1 string -- the base path of the source tree
---@param path2 string -- the new base path for the destination
---@param file_fun fun(p1: string, p2: string): any -- an optional function to apply on all files
---@param verbose boolean|fun(...)? -- an optional boolean to control the verbosity of the output. It can also be a logging function that behaves like `print()`
---@return true? -- `true` on success or `nil`
---@return string|string[]? -- message on failure or list of failed directory creations on success
---@return string[]? -- list of failed file operations on success
---
---Raises: `path1` and `path2` must be strings
---
---Usage:
---
---```lua
---clonetree('.', '../backup', copyfile)
---```
function dir.clonetree(path1, path2, file_fun, verbose) end

---Return an iterator over all entries in a directory tree
---@param d string -- a directory
---@return (fun(): string, boolean) -- iterator giving pathname and mode (`true` for dir, `false` otherwise)
---@return any
---
---Raises: `d` must be a non-empty string
function dir.dirtree(d) end

---Recursively returns all the file starting at `path`. It can optionally take a shell pattern and
---only returns files that match `shell_pattern`. If a pattern is given it will do a case insensitive search.
---@param start_path string? -- A directory. (default '.')
---@param shell_pattern string? -- A shell pattern (see `fnmatch`). (default '*')
---@return pl.List -- list containing all the files found recursively starting at `path` and filtered by `shell_pattern`
---
---Raises: `start_path` must be a directory
function dir.getallfiles(start_path, shell_pattern) end

return dir
