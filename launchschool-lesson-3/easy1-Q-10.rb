flintstone = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}
flintstone.each_with_index do |name, index|
   flintstones_hash[name] = index
   puts flintstones_hash
end
