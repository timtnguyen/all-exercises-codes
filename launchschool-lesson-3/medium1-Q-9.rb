munsters = {
  "Herman"  => { "age" => 32, "gender" => "male"},
  #{}"Lily"    => { "age" => 30, "gender" => "female"},
  #{}"Grandpa" => { "age" => 402,"gender" => "male"},
  #{}"Eddie"   => { "age" => 10, "gender" => "male"},
  #{}"Marilyn" => { "age" => 23, "gender" => "female"}
}
new_munsters = Hash.new { |hsh,key| hsh[key] = {} }
new_munsters["Herman"].store "age_range", "junior"
puts new_munsters
