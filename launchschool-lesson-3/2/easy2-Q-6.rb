ages = {
  "Herman"   => 32,
  "Lily"     => 30,
  "Grandpa"  => 5843,
  "Eddie"    => 10,
  "Marilyn"  => 22,
  "Spots"     => 237
}

#puts ages.group_by { |k, v| v}.min_by { |k, v| k}.last.to_h

puts ages.group_by(&:last).min_by(&:first).last.to_h
