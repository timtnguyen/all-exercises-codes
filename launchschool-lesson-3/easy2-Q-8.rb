flintstones = %w(Fred Barney Wilma Betty BamBam Pebble)

puts flintstones.index { |name| name[0,2] == "Be"}
