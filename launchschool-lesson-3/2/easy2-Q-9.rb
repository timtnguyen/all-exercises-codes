flintstones = %w(Fred Barney Wilma Betty BamBam Pebble)

p flintstones.map! { |name| name.slice(0, 3)}
