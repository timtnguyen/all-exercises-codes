def prompt(message)
  Kernel.puts "=> #{message}"
end

def valid_number?(num)
  num.to_i() != 0
end

def operation(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

  prompt("Welcome!! Enter your name")
  name = ''
  loop do
    name = Kernel.gets().chomp()
    if name.empty?()
      prompt("Enter your name!")
    else
      break
    end
  end
  prompt("Hi, #{name}!")

  loop do
  number1 = ''
  loop do
    prompt("What is your first number?")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("Enter a valid number")
    end
  end

  number2 = ''
  loop do
    prompt("What is your second number?")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("Enter a valid number")
    end
  end

  operation_cate = <<-MSG
    What would you like to calculate?(enter 1 for adding, 2 for subtracting etc.)
      1, Adding
      2, Subtracting
      3, Multiplying
      4, Dividing
    MSG

    prompt(operation_cate)

  operator = ''

  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Enter a number 1, 2, 3 or 4")
    end
  end

  prompt("#{operation(operator)} the two number...")

  results = case operator
  when '1'
    number1.to_i() + number2.to_i()
  when '2'
    number1.to_i() - number2.to_i()
  when '3'
    number1.to_i() * number2.to_i()
  when '4'
    number1.to_f() / number2.to_f()
  end
  prompt("The result is: #{results}")

  prompt("Do you want another calculation?(Y to calculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')

end
prompt("Thank you for using calculator. Goodbye!!")
