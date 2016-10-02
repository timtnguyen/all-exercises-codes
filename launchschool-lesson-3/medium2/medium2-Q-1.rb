munsters = {
  "Herman"  => { "age" => 32,  "gender" => "male"},
  "Lily"    => { "age" => 30,  "gender" => "female"},
  "Grandpa" => { "age" => 403, "gender" => "male"},
  "Eddies"   => { "age" => 10,  "gender" => "male"}
}
total_age = 0
munsters.each do |name, detail|
  if detail["gender"] == "male"
    puts total_age += detail["age"]
  end
end
