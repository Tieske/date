local date = require("date")

describe("Testing the 'date' module", function()

  it("Tests date parsing", function()
    assert( date("Jul 27 2006 03:56:28 +2:00") == date(2006,07,27,1,56,28))
    assert(date("Jul 27 2006 -75 ") == date(2006,07,27,1,15,0))
    assert(date("Jul 27 2006 -115") == date(2006,07,27,1,15,0))
    assert(date("Jul 27 2006 +10 ") == date(2006,07,26,14,0,0))
    assert(date("Jul 27 2006 +2  ") == date(2006,07,26,22,0,0))

    -- Standard timezone GMT, UTC, EST, EDT, CST, CDT, MST, MDT, PST, PDT are supported.
    assert(date("Jul 27 2006 GMT") == date(2006,07,27,0,0,0))
    assert(date("Jul 27 2006 UTC") == date(2006,07,27,0,0,0))
    assert(date("Jul 27 2006 EST") == date(2006,07,27,5,0,0))
    assert(date("Jul 27 2006 EDT") == date(2006,07,27,4,0,0))
    assert(date("Jul 27 2006 CST") == date(2006,07,27,6,0,0))
    assert(date("Jul 27 2006 CDT") == date(2006,07,27,5,0,0))
    assert(date("Jul 27 2006 MST") == date(2006,07,27,7,0,0))
    assert(date("Jul 27 2006 MDT") == date(2006,07,27,6,0,0))
    assert(date("Jul 27 2006 PST") == date(2006,07,27,8,0,0))
    assert(date("Jul 27 2006 PDT") == date(2006,07,27,7,0,0))
    -- Date Format.  Short dates can use either a "/" or "-" date separator,
    -- but must follow the month/day/year format
    assert(date("02-03-04")==date(1904,02,03))
    assert(date("12/25/98")==date(1998,12,25))
    -- Long dates of the form "July 10 1995" can be given with the year, month,
    -- and day in any order, and the year in 2-digit or 4-digit form. If you use
    -- the 2-digit form, the year must be greater than or equal to 70.
    assert(date("Feb-03-04")==date(1904,02,03))
    assert(date("December 25 1998")==date(1998,12,25))
    -- Follow the year with BC or BCE to indicate that the year is before common era.
    assert(date("Feb 3 0003 BC")==date(-2,02,03))
    assert(date("December 25 0001 BC")==date(0,12,25))

    -- Supported ISO 8601 Formats.
    -- YYYY-MM-DDwhere YYYY is the year, MM is the month of the year, and DD is the
    -- day of the month.
    assert(date("2000-12-31")==date(2000,12,31))
    assert(date(" 20001231 ")==date(2000,12,31)) -- Compact version
    -- YYYY-DDDwhere YYYY is the year, DDD is the day of the year.
    assert(date("1995-035")==date(1995,02,04))
    assert(date("1995035 ")==date(1995,02,04)) -- Compact version
    -- YYYY-WDD-Dwhere YYYY is the year, DD is the week of the year, D is the day of
    -- the week.
    assert(date("1997-W01-1")==date(1996,12,30))
    assert(date("  1997W017")==date(1997,01,05)) -- Compact version
    -- DATE HH:MM:SS.SSSWhere DATE is the date format discuss above, HH is the hour,
    -- MM is the miute, SS.SSS is the seconds (fraction is optional).
    assert(date("1995-02-04 24:00:51.536")==date(1995,2,5,0,0,51.536))
    assert(date("1976-W01-1 12:12:12.123")==date(1975,12,29,12,12,12.123))
    assert(date("1995-035 23:59:59.99999")==date(1995,02,04,23,59,59.99999))
    -- Compact version separated by latin capital letter T
    assert(date("  19950205T000051.536  ")==date(1995,2,5,0,0,51.536))
    assert(date("  1976W011T121212.123  ")==date(1975,12,29,12,12,12.123))
    assert(date(" 1995035T235959.99999  ")==date(1995,02,04,23,59,59.99999))
    -- DATE TIME +HH:MM, DATE TIME -HHMM, DATE TIME Z,Where DATE and TIME is the date
    -- and time format discuss above. First character is a sign "+" (east of UTC) or "-"
    -- (west of UTC). HH and MM is Hours and minutes offset. The Z stands for the zero offset.
    assert(date("1976-W01-1 12:00Z     ")==date(1975,12,29,12))
    assert(date("1976-W01-1 13:00+01:00")==date(1975,12,29,12))
    assert(date("1976-W01-1 0700-0500  ")==date(1975,12,29,12))

    local a = date(2006, 8, 13)   assert(a == date("Sun Aug 13 2006"))
    local b = date("Jun 13 1999") assert(b == date(1999, 6, 13))
    local c = date(1234483200)    assert(c == date("Feb 13 2009"))
    local d = date({year=2009, month=11, day=13, min=6})
    assert(d == date("Nov 13 2009 00:06:00"))
    local e = date()              assert(e)
  end)

  it("Tests century-flip", function()
    local old = date.getcenturyflip()
    finally(function()
      date.setcenturyflip(old)
    end)

    assert(old==0)
    assert(date("01-01-00")==date(1900,01,01))
    assert(date("01-01-50")==date(1950,01,01))
    assert(date("01-01-99")==date(1999,01,01))
    date.setcenturyflip(100)
    assert(date("01-01-00")==date(2000,01,01))
    assert(date("01-01-50")==date(2050,01,01))
    assert(date("01-01-99")==date(2099,01,01))
    date.setcenturyflip(50)
    assert(date("01-01-00")==date(2000,01,01))
    assert(date("01-01-49")==date(2049,01,01))
    assert(date("01-01-50")==date(1950,01,01))
    assert(date("01-01-99")==date(1999,01,01))
  end)

  it("Tests leap year", function()
    assert.is_true(date.isleapyear(2012))
    assert.is_true(date.isleapyear(2000))
    assert.is_false(date.isleapyear(2011))
    assert.is_false(date.isleapyear(1900))
  end)

  it("Tests date equality", function()
    local a = date("20131230 00:57:04")
    assert(a:getyear()    == 2013)
    assert(a:getmonth()   == 12)
    assert(a:getday()     == 30)
    assert(a:gethours()   == 0)
    assert(a:getminutes() == 57)
    assert(a:getseconds() == 04)
    local b = date("20131230 01:00:00")
    local c = date("20131230 00:57:04")  -- same as a
    assert(a < b)
    assert(a <= b)
    assert(not (a > b))
    assert(not (a >= b))
    assert(a == c)
    assert(a <= c)
    assert(a >= c)
  end)

  it("Tests metamethods", function()
    local a = date(1521,5,2)
    local b = a:copy():addseconds(0.001)

    assert((a - b):spanseconds() == -0.001)
    assert((a + b) == (b + a))
    assert(a == (b - date("00:00:00.001")) )
    assert(b == (a + date("00:00:00.001")) )

    b:addseconds(-0.01)

    assert(a >  b and b <  a)
    assert(a >= b and b <= a)
    assert(a ~= b and (not(a == b)))

    a = b:copy()

    assert(not (a >  b and b <  a))
    assert(a >= b and b <= a)
    assert(a == b and (not(a ~= b)))

    assert((a .. 565369) == (b .. 565369))
    assert((a .. "????") == (b .. "????"))
  end)

  it("Tests 'adddays()'", function()
    local a = date(2000,12,30)
    local b = date(a):adddays(3)
    local c = date.diff(b,a)
    assert(c:spandays() == 3)
  end)

  it("Tests 'addhours()'", function()
    local a = date(2000,12,30)
    local b = date(a):addhours(3)
    local c = date.diff(b,a)
    assert(c:spanhours() == 3)
  end)

  it("Tests 'addminutes()'", function()
    local a = date(2000,12,30)
    local b = date(a):addminutes(3)
    local c = date.diff(b,a)
    assert(c:spanminutes() == 3)
  end)

  it("Tests 'addseconds()'", function()
    local a = date(2000,12,30)
    local b = date(a):addseconds(3)
    local c = date.diff(b,a)
    assert(c:spanseconds() == 3)
  end)

  it("Tests 'addmonths()'", function()
    local a = date(2000,12,28):addmonths(3)
    assert(a:getmonth() == 3)
  end)

  it("Tests 'addticks()'", function()
    local a = date(2000,12,30)
    local b = date(a):addticks(3)
    local c = date.diff(b,a)
    assert(c:spanticks() == 3)
  end)

  it("Tests 'addyears()'", function()
    local a = date(2000,12,30):addyears(3)
    assert(a:getyear() == (2000+3))
  end)

  it("Tests 'copy()'", function()
    local a = date(2000,12,30)
    local b = a:copy()
    assert(a==b)
  end)

  it("Tests 'fmt()'", function()
    local d = date(1582,10,5)
    assert(d:fmt('%D') == d:fmt("%m/%d/%y"))        -- month/day/year from 01/01/00 (12/02/79)
    assert(d:fmt('%F') == d:fmt("%Y-%m-%d"))        -- year-month-day (1979-12-02)
    assert(d:fmt('%h') == d:fmt("%b"))                      -- same as %b (Dec)
    assert(d:fmt('%r') == d:fmt("%I:%M:%S %p"))     -- 12-hour time, from 01:00:00 AM (06:55:15 AM)
    assert(d:fmt('%T') == d:fmt("%H:%M:%S"))        -- 24-hour time, from 00:00:00 (06:55:15)
    assert(d:fmt('%a %A %b %B') == "Tue Tuesday Oct October")
    assert(d:fmt('%C %d') == "15 05", d:fmt('%C %d'))
    local d2 = date(1446747300.00008)
    assert.is.equals(d2:fmt('%\f'),"00.000080109")

  end)

  it("Tests 'getclockhour()'", function()
    local a = date("10:59:59 pm")
    assert(a:getclockhour()==10)
  end)

  it("Tests 'getdate()'", function()
    local a = date(1970, 1, 1)
    local y, m, d = a:getdate()
    assert(y == 1970 and m == 1 and d == 1)
  end)

  it("Tests 'getday()'", function()
    local d = date(1966, 'sep', 6)
    assert(d:getday() == 6)
  end)

  it("Tests 'getfracsec()'", function()
    local d = date("Wed Apr 04 2181 11:51:06.996 UTC")
    assert(d:getfracsec() == 6.996)
  end)

  it("Tests 'gethours()'", function()
    local d = date("Wed Apr 04 2181 11:51:06 UTC")
    assert(d:gethours() == 11)
  end)

  it("Tests 'getisoweekday()'", function()
    local d = date(1970, 1, 1)
    assert(d:getisoweekday() == 4)
  end)

  it("Tests 'getisoweeknumber()'", function()
    local d = date(1975, 12, 29)
    assert(d:getisoweeknumber() == 1)
    assert(d:getisoyear() == 1976)
    assert(d:getisoweekday() == 1)
    d = date(1977, 1, 2)
    assert(d:getisoweeknumber() == 53)
    assert(d:getisoyear() == 1976)
    assert(d:getisoweekday() == 7)
  end)

  it("Tests 'getisoyear()'", function()
    local d = date(1996, 12, 30)
    assert(d:getisoyear() == 1997)
    d = date(1997, 01, 05)
    assert(d:getisoyear() == 1997)
  end)

  it("Tests 'getminutes'", function()
    local d = date("Wed Apr 04 2181 11:51:06 UTC")
    assert(d:getminutes() == 51)
  end)

  it("Tests 'getmonth'", function()
    local d = date("Wed Apr 04 2181 11:51:06 UTC")
    assert(d:getmonth() == 4)
  end)

  it("Tests 'getseconds'", function()
    local d = date("Wed Apr 04 2181 11:51:06 UTC")
    assert(d:getseconds() == 6)
  end)

  it("Tests 'getticks()'", function()
    local d = date("Wed Apr 04 2181 11:51:06.123 UTC")
    assert(d:getticks() == 123000)
  end)

  it("Tests 'gettime()'", function()
    local a = date({hour=5,sec=.5,min=59})
    local h, m, s, t = a:gettime()
    assert(t == 500000 and s == 0 and m == 59 and h == 5, tostring(a))
  end)

  it("Tests 'getweekday()'", function()
    local d = date(1970, 1, 1)
    assert(d:getweekday() == 5)
  end)

  it("Tests 'getweeknumber()'", function()
    local a = date("12/31/1972")
    local b,c = a:getweeknumber(), a:getweeknumber(2)
    assert(b==53 and c==52)
  end)

  it("Tests 'getyear()'", function()
    local d = date(1965, 'jan', 0)
    assert(d:getyear() == 1964)
  end)

  it("Tests 'getyearday()'", function()
    local d = date(2181, 1, 12)
    assert(d:getyearday() == 12)
  end)

  it("Tests 'setday()'", function()
    local d = date(1966, 'july', 6)
    d:setday(1)
    assert(d == date("1966 july 1"))
  end)

  it("Tests 'sethours()'", function()
    local d = date(1984, 12, 3, 4, 39, 54)
    d:sethours(1, 1, 1)
    assert(d == date("1984 DEc 3 1:1:1"))
  end)

  it("Tests 'setisoweekday()'", function()
    local d = date.isodate(1999, 52, 1)
    d:setisoweekday(7)
    assert(d == date(2000, 1, 02))
  end)

  it("Tests 'setisoweeknumber()'", function()
    local d = date(1999, 12, 27)
    d:setisoweeknumber(51, 7)
    assert(d == date(1999, 12, 26))
  end)

  it("Tests 'setisoyear()'", function()
    local d = date(1999, 12, 27)
    d:setisoyear(2000, 1)
    assert(d == date.isodate(2000,1,1))
    assert(d:getyear() == 2000)
    assert(d:getday() == 3)
  end)

  it("Tests 'setminutes()'", function()
    local d = date(1984, 12, 3, 4, 39, 54)
    d:setminutes(59, 59, 500)
    assert(d == date(1984, 12, 3, 4, 59, 59, 500))
  end)

  it("Tests 'setmonth()'", function()
    local d = date(1966, 'july', 6)
    d:setmonth(1)
    assert(d == date("6 jan 1966"))
  end)

  it("Tests 'setseconds()'", function()
    local d = date(1984, 12, 3, 4, 39, 54)
    d:setseconds(59, date.ticks())
    assert(d == date(1984, 12, 3, 4, 40))
  end)

  it("Tests 'setticks()'", function()
    local d = date(1984, 12, 3, 4, 39, 54)
    d:setticks(444)
    assert(d == date(1984, 12, 3, 4, 39, 54, 444))
  end)

  it("Tests 'setyear()'", function()
    local d = date(1966, 'july', 6)
    d:setyear(2000)
    assert(d == date("jul 6 2000"))
  end)

  it("Tests 'spandays()'", function()
    local a = date(2181, "aPr", 4, 6, 30, 30, 15000)
    local b = date(a):adddays(2)
    local c = date.diff(b, a)
    assert(c:spandays() == (2))
  end)

  it("Tests 'spanhours()'", function()
    local a = date(2181, "aPr", 4, 6, 30, 30, 15000)
    local b = date(a):adddays(2)
    local c = date.diff(b, a)
    assert(c:spanhours() == (2*24))
  end)

  it("Tests 'spanminutes()'", function()
    local a = date(2181, "aPr", 4, 6, 30, 30, 15000)
    local b = date(a):adddays(2)
    local c = date.diff(b, a)
    assert(c:spanminutes() == (2*24*60))
  end)

  it("Tests 'spanseconds()'", function()
    local a = date(2181, "aPr", 4, 6, 30, 30, 15000)
    local b = date(a):adddays(2)
    local c = date.diff(b, a)
    assert(c:spanseconds() == (2*24*60*60))
  end)

  it("Tests 'spanticks()'", function()
    local a = date(2181, "aPr", 4, 6, 30, 30, 15000)
    local b = date(a):adddays(2)
    local c = date.diff(b, a)
    assert(c:spanticks() == (2*24*60*60*1000000))
  end)

end)
