local package_name = "date"
local package_version = "dev"
local rockspec_revision = "1"
local github_account_name = "Tieske"
local github_repo_name = package_name
local git_checkout = package_version == "dev" and "master" or ("version_"..package_version)

package = package_name
version = package_version .. "-" .. rockspec_revision

source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = git_checkout
}

description = {
  summary = "Date & Time module for Lua 5.x",
  detailed = [[
    Pure Lua Date & Time module for Lua 5.x featuring date and time string
    parsing, time addition & subtraction, time span calculation, support for
    ISO 8601 dates, local time support, strftime-like formatting.
  ]],
  license = "MIT",
  homepage = "https://github.com/"..github_account_name.."/"..github_repo_name,
}

dependencies = {
  "lua >= 5.0, < 5.6"
}

build = {
  type = "builtin",
  modules = {
    date = "src/date.lua"
  },
  copy_directories = { "docs" },
}
