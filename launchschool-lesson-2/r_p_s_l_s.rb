VALID_CHOICES = %w(rock paper scissor lizard spock)

#WINNING_COMBO = [['lizard', 'scissor'], ['rock', 'spock'], ['lizard', 'paper'],
                #['spock', 'paper'], ['scissor', 'rock']]
def prompt(message)
  Kernel.puts "=> #{message}"
end

wins = losses = draws = 0

name = ''
  loop do
    prompt("Welcome to our game. Plese enter your name")
    name = Kernel.gets().chomp()
  if name.empty?()
    prompt("Must enter your name")
  else
    break
  end
end
prompt("Hi, #{name}!")

loop do
  human_choice = ''
  loop do
    prompt("What is your choice, #{VALID_CHOICES.join(', ')}")
    human_choice = Kernel.gets().chomp()
    if VALID_CHOICES.include?(human_choice)
      break
    else
      prompt("Must enter valid choice")
    end
  end
  computer_choice = VALID_CHOICES.sample
  prompt("You choose: #{human_choice}, computer choose: #{computer_choice}")

  if human_choice == 'rock' && computer_choice == 'lizard' || computer_choice == 'scissor'
    wins += 1
    prompt("you win")
  elsif human_choice == 'paper' && computer_choice == 'rock' || computer_choice == 'spock'
    wins += 1
    prompt("you win")
  elsif human_choice == 'scissor' && computer_choice == 'paper' || computer_choice == 'lizard'
    wins += 1
    prompt("you win")
  elsif human_choice == 'lizard' && computer_choice == 'paper' || computer_choice == 'spock'
    wins += 1
    prompt("you win")
  elsif human_choice == 'spock' && computer_choice == 'rock' || computer_choice == 'scissor'
    wins += 1
    prompt("you win")
  elsif computer_choice == 'rock' && human_choice == 'lizard' || human_choice == 'scissor'
    losses += 1
    prompt("computer win")
  elsif computer_choice == 'paper' && human_choice == 'rock' || human_choice == 'spock'
    losses += 1
    prompt("computer win")
  elsif computer_choice == 'scissor' && human_choice == 'paper' || human_choice == 'lizard'
    losses += 1
    prompt("computer win")
  elsif computer_choice == 'lizard' && human_choice == 'paper' || human_choice == 'spock'
    losses += 1
    prompt("computer win")
  elsif computer_choice == 'spock' && human_choice == 'rock' || human_choice == 'scissor'
    losses += 1
    prompt("computer win")
  else
    draws += 1
    prompt("It's a tie")
  end

  prompt("Wins: #{wins}\nLosses: #{losses}\nDraws: #{draws}")
  if wins < 5
    wins += 1
    prompt("You won this game")
  else losses < 5
    losses += 1
    prompt("You loss this game")
end
end
