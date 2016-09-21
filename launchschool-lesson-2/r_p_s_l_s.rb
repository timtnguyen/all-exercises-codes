VALID_CHOICES = %w(rock paper scissor lizard spock)

def prompt(message)
  Kernel.puts "=> #{message}"
end

def win?(first, second)
  (first == 'scissor' && (second == 'lizard' || second == 'paper')) ||
    (first == 'rock' && (second == 'lizard' || second == 'scissor')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'lizard' && (second == 'paper' || second == 'spock')) ||
    (first == 'spock' && (second == 'rock' || second == 'scissor'))
end

def results(player, computer)
  if win?(player, computer)
    prompt("You won!!")
  elsif win?(computer, player)
    prompt("Computer won")
  else
    prompt("It's a tie!")
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

prompt("Thank you for playing the game. See you later")
