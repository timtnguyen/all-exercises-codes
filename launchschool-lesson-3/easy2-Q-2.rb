ages = {
  "Herman"   => 32,
  "Lily"     => 30,
  "Grandpa"  => 5843,
  "Eddie"    => 10,
  "Marilyn"  => 22,
  "Spots"     => 237
}
 puts ages.inject(0) { |total, age| total += age[1]}
