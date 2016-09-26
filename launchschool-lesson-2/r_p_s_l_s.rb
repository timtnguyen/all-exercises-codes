VALID_CHOICES = %w(rock paper scissor lizard spock)

WINNING_COMBO = {
  'rock' => %w(scissor lizard),
  'paper' => %w(rock spock),
  'scissor' => %w(lizard paper),
  'lizard' => %w(spock paper),
  'spock' => %w(rock scissor)
}

def prompt(message)
  Kernel.puts "=> #{message}"
end

def win?(first, second)
  WINNING_COMBO[first].include?(second)
end

def results(player, computer)
  if win?(player, computer)
    prompt("you win")
  elsif win?(computer, player)
    prompt("computer win")
  else
    prompt("It's a tie")
  end
end
wins = 0
losses = 0
draws = 0

prompt("Enter your name to play")
name = ''
loop do
  name = Kernel.gets(). chomp()

  if name.empty?() || name == ''
    prompt("Enter a valid name")
  else
    break
  end
end
prompt("Hi, #{name}!")

operation_abbrev = <<-MSG
  Please enter your choice(example: 'r' for 'rock'and 'l' for 'lizard' etc.
  First one reached 5 will win the round. Let's play)
   r = rock
   p = paper
   s = scissor
   l = lizard
   ss = spock
MSG
prompt(operation_abbrev)
loop do
  loop do
    choices = ''
    loop do
      prompt("What is your choice?")
      choices_abbrev = Kernel.gets().chomp().downcase()
      if choices_abbrev == 'r'
        choices = 'rock'
      elsif choices_abbrev == 'p'
        choices = 'paper'
      elsif choices_abbrev == 's'
        choices = 'scissor'
      elsif choices_abbrev == 'l'
        choices = 'lizard'
      elsif choices_abbrev == 'ss'
        choices = 'spock'
      end

      if VALID_CHOICES.include?(choices)
        break
      else
        prompt("Enter valid choice")
      end
    end
    computer_choices = VALID_CHOICES.sample

    prompt("You choose: #{choices}, computer choose: #{computer_choices}")

    prompt(results(choices, computer_choices))

    if win?(choices, computer_choices)
      wins += 1
    elsif win?(computer_choices, choices)
      losses += 1
    else
      draws += 1
    end

    prompt("Total count of wins, losses or draws")
    prompt("Wins: #{wins}\nLosses: #{losses}\nDraws: #{draws}")

    if wins == 5
      prompt("You won the round")
      wins = 0
      losses = 0
      draws = 0
      break
    elsif losses == 5
      prompt("You loss the round, computer won")
      wins = 0
      losses = 0
      draws = 0
      break
    end
  end

  prompt("Do you want to play again?(Y to play again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing the game. See you again. Goodbye!!")
