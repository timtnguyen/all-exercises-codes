munsters = {
  "Herman"  => { "age" => 32,  "gender" => "male"},
  "Lily"    => { "age" => 30,  "gender" => "female"},
  "Grandpa" => { "age" => 403, "gender" => "male"},
  "Eddie"   => { "age" => 10,  "gender" => "male"}
}
munsters.each do
 ages = munsters["age"].inject(0) { |total, age| total += age[1]}
puts ages
