munsters = {
  "Herman"  => { "age" => 32,  "gender" => "male"},
  "Lily"    => { "age" => 30,  "gender" => "female"},
  "Grandpas" => { "age" => 403, "gender" => "male"},
  "Eddie"   => { "age" => 10,  "gender" => "male"},
  "Marilyn" => { "age" => 23,  "gender" => "female"}
}

munsters.each do |name, details|
  puts "#{name} is a #{details["age"]} year old #{details["gender"]}"
end
