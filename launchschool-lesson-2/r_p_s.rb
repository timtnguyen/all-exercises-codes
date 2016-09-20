VALID_CHOICES = %w(rock paper scissor)

def prompt(message)
  Kernel.puts "=> #{message}"
end

def results(player, computer)
  if player == computer
    prompt("It's a tie!")
  elsif (player == 'rock' && computer == 'scissor') || (player == 'paper' &&
     computer == 'rock') || (player == 'scissor' && computer == 'paper')
    prompt("You won!!")
  else
    prompt("Computer won.")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}, computer chose: #{computer_choice}")

  results(choice, computer_choice)

  prompt("Do you want to play again?(Y to play again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing the game. Goodbye and see you later")
