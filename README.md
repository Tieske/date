#LuaDate v2.1

[![travis-ci status](https://secure.travis-ci.org/Tieske/date.png)](http://travis-ci.org/#!/Tieske/date/builds)

Lua Date and Time module for Lua 5.x.

##Features:

* Date and Time string parsing.
* Time addition and subtraction.
* Time span calculation.
* Support ISO 8601 Dates.
* Local time support.
* Lua module (not binary).
* Formats Date and Time like strftime.

## License
[MIT license](http://opensource.org/licenses/MIT).

## Tests

Tests are located in the `spec` directory and can be run using [busted](http://olivinelabs.com/busted/).

##Changes:

- v2.1.1 fix for '>=' operator [#3](https://github.com/Tieske/date/pull/3), added test suite, added Travis CI, license MIT
- v2.1 Lua 5.2 support. Global 'date' will no longer be set.
- v2.0 original by Jas Latrix