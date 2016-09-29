numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# => 1, 3

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# => 1, 2

# It compared against the current length instead of its original length 
