def factors(number)
  dividend = number
  divisors = []
while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
end
divisors
end
p factors(10)

# 1, Make sure the number with no remainder

# 2, return the value divisors 
