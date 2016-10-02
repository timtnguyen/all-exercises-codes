statements = "The Flintstones Rock"

array = statements.downcase.gsub(/[^a-z]/, '').chars
h = Hash.new(0)
 array.each { |c| h[c] += 1}
puts h
