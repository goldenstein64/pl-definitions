package = "penlight"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      config = "config.lua",
      crawlDocs = "crawlDocs.lua",
      ["library.pl.app"] = "library/pl/app.lua",
      ["library.pl.array2d"] = "library/pl/array2d.lua",
      ["library.pl.init"] = "library/pl/init.lua"
   }
}
