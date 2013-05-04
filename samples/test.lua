require 'date'

d1 = date('July 4 2009')
assert(d1:getmonth() == 7)
d2 = d1:copy()
d2:adddays(2)
diff = d2 - d1
assert(diff:spandays() == 2)
assert(diff:spanhours() == 48)

assert(date 'July 4 2009' == date '2009-07-04')

a = date(1970, 1, 1)
y, m, d = a:getdate()
assert(y == 1970 and m == 1 and d == 1)

d = date(1966, 'sep', 6)
assert(d:getday() == 6)





