package = "date"
version = "2.0.1-1"

description = {
   summary = "Date & Time module for Lua 5.x",
   detailed = [[
      Pure Lua Date & Time module for Lua 5.x featuring date and Time string
      parsing, time addition & subtraction, time span calculation, support for
      ISO 8601 Dates, local time support, strftime-like formatting.
   ]],
   license = "Public Domain",
   homepage = "http://luaforge.net/projects/date/",
}

dependencies = {
   "lua ~> 5.1"
}

source = {
   url = "http://luaforge.net/frs/download.php/1708/date.zip",
   dir = ".",
}

build = {
   type = "builtin",
   modules = {
      date = "date.lua"
   }
}
