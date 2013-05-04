package = "date"
version = "1.0-1"
source = {
   url = "http://luaforunix.luaforge.net/packages/date-1.0-1.tar.gz",
}
description = {
   summary    = "Lua Date and Time module for Lua 5.1",
   detailed   = [[
    Date and Time string parsing; Time addition and subtraction;
    Time span calculation; Supports ISO 8601 Dates.
   ]],
   license    =  "MIT/X11",
   homepage   = "http://luaforge.net/projects/date/",
   maintainer = "Steve Donovan <steve.j.donovan@gmail.com>",
}
dependencies = {
}
build = {
  type = "none",
  copy_directories = {'doc','samples'},
  install = {
     lua = {
        date = "date.lua"
     }
  }
}

