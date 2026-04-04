local path = require("pl.path")

local dir, file = path.splitpath("some/dir/myfile.txt")
assert(dir == "some/dir")
assert(file == "myfile.txt")

local dir, file = path.splitpath("some/dir/")
assert(dir == "some/dir")
assert(file == "")

local dir, file = path.splitpath("some_dir")
assert(dir == "")
assert(file == "some_dir")

local file_path, ext = path.splitext("/bonzo/dog_stuff/cat.txt")
assert(file_path == "/bonzo/dog_stuff/cat")
assert(ext == ".txt")

local file_path, ext = path.splitext("")
assert(file_path == "")
assert(ext == "")

assert(path.dirname("/some/path/file.txt") == "/some/path")
assert(path.dirname("file.txt") == "")

assert(path.basename("/some/path/file.txt") == "file.txt")
assert(path.basename("/some/path/file/") == "")

assert(path.extension("/some/path/file.txt") == ".txt")
assert(path.extension("/some/path/file_txt") == "")

assert(not path.isabs("hello/path"))
assert(path.isabs("/hello/path"))

-- Windows paths
assert(not path.isabs("hello\\path"))
assert(path.isabs("\\hello\\path"))
assert(path.isabs("C:\\hello\\path"))
assert(not path.isabs("C:hello\\path"))

assert(path.join("/first", "second", "third") == "/first/second/third")
assert(path.join("first", "second/third") == "first/second/third")
assert(path.join("/first", "/second", "third") == "/second/third")

if path.is_windows then
	assert(path.normcase("/Some/Path/File.txt") == "\\some\\path\\file.txt")
else
	assert(path.normcase("/Some/Path/File.txt") == "/Some/Path/File.txt")
end
