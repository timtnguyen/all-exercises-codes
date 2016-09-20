def prompt(message)
  Kernel.puts "=> #{message}"
end

def valid_number?(num)
  num.to_i() >= 0
end
loop do
  prompt("Welcome to car loan calculator!")

  prompt("What is the loan amount?")
  amount = ''

  loop do
    amount = Kernel.gets().chomp()
    if valid_number?(amount)
      break
    else
      prompt("Enter a valid number")
    end
  end

  prompt("What is the interest rate? enter 5 for 5% and 12 for 12%")

  annual_percentage_rate = ''
  loop do
    annual_percentage_rate = Kernel.gets().chomp()
    if valid_number?(annual_percentage_rate)
      break
    else
      prompt("Enter the valid number")
    end
  end

  prompt("How long is the loan for?(in years)")

  years = ''

  loop do
    years = Kernel.gets().chomp()

    if valid_number?(years)
      break
    else
      prompt("Enter a valid number")
    end
  end

  annual_interest = annual_percentage_rate.to_f() / 100
  monthly_interest_rate = annual_interest / 12
  months = years.to_i() * 12
  monthly_payment = amount.to_f() * (monthly_interest_rate /
  (1 - (1 + monthly_interest_rate)**-months.to_i()))

  prompt("The monthly payment is: #{monthly_payment.round(2)}")

  prompt("Do you want another calculation?(Y to do it again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using the calculator. Goodbye!!")
