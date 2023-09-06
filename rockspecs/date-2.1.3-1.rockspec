package = "date"
version = "2.1.3-1"

description = {
   summary = "Date & Time module for Lua 5.x",
   detailed = [[
      Pure Lua Date & Time module for Lua 5.x featuring date and time string
      parsing, time addition & subtraction, time span calculation, support for
      ISO 8601 dates, local time support, strftime-like formatting.
   ]],
   license = "MIT",
   homepage = "https://github.com/Tieske/date",
}

dependencies = {
   "lua >= 5.0, < 5.5"
}

source = {
   url = "git://github.com/Tieske/date/",
   tag = "version_2.1.3",
}

build = {
   type = "builtin",
   modules = {
      date = "src/date.lua"
   },
   copy_directories = { "docs" },
}

