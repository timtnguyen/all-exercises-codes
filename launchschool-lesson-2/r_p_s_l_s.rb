VALID_CHOICES = %w(rock paper scissor lizard spock).freeze

WINNING_COMBO = {
  'rock' => %w(scissor lizard),
  'paper' => %w(rock spock),
  'scissor' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissor)
}
wins = losses = draws = 0
def prompt(message)
  Kernel.puts "=> #{message}"
end
def win?(first, second)
  (first == 'rock' && second == 'scissor' || second == 'lizard') ||
  (first == 'paper' && second == 'rock' || second == 'spock') ||
  (first == 'scissor' && second == 'paper' || second == 'lizard') ||
  (first == 'lizard' && second == 'paper' || second == 'spock') ||
  (first == 'spock' && second == 'rock' || second == 'scissor')
end



def results(player, computer)
  if win?(player, computer)
    prompt("you win")
  elsif win?(computer, player)
    prompt("computer win")
  else
    prompt("It's a tie!")
  end
end

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

choice_abbre = <<-MSG
  You must choose one of the following choices(example: enter 'r' if your
  choice is 'rock' etc). The first to win 5 games will win the round.
     r = 'rock'
     p = 'paper'
     s = 'scissor'
     l = 'lizard'
     ss = 'spock'
  MSG
prompt(choice_abbre)

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

loop do
  choice = ''
  loop do
    choice = Kernel.gets().chomp()
    if %w(r p s l ss).include?(choice)
      break
    else
      prompt("Enter a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You choose: #{operation(choice)}, computer choose: #{computer_choice}")
  results(choice, computer_choice)

  prompt("Do you want to play again?(Y to play again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
