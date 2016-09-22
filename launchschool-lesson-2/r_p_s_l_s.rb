VALID_CHOICES = %w(r p s l ss)

def prompt(message)
  Kernel.puts "=> #{message}"
end

def win?(first, second)
  (first == 's' && (second == 'l' || second == 'p')) ||
    (first == 'r' && (second == 'l' || second == 's')) ||
    (first == 'p' && (second == 'r' || second == 'ss')) ||
    (first == 'l' && (second == 'p' || second == 'ss')) ||
    (first == 'ss' && (second == 'r' || second == 's'))
end

def operation(op)
  case op
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissor'
  when 'l'
    'lizard'
  when 'ss'
    'spock'
  end
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

prompt("Enter your name to play")
name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("Enter your name")
  else
    break
  end
end
prompt("Hi, #{name}!")

short_listed = <<-MSG
    Choose one of the letter for your choice
        r = rock
        p = paper
        s = scissor
        l = lizard
        ss = spock
    MSG

prompt(short_listed)

loop do
  choice = ''
  loop do
    prompt("What is your choice?")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{operation(choice)},
  computer chose: #{operation(computer_choice)}")
  results(choice, computer_choice)

  prompt("Do you want to play again?(Y to play again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing the game. See you later")
