local date = require("date")

describe("Testing the 'date' module", function()

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

end)
