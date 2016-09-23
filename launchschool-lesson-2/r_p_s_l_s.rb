VALID_CHOICES = %w(rock paper scissor lizard spock).freeze

WINNING_COMBO = {
  'rock' => %w(scissor lizard),
  'paper' => %w(rock spock),
  'scissor' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissor)
}

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

  def win?(first, second)
    WINNING_COMBO[first].include?(second)
  end

  def results(player, computer)
    if win?(player, computer)
      wins += 1
      prompt("you win")
    elsif win?(computer, player)
      losses + 1
      prompt("computer win")
    else
      draws += 1
      prompt("It's a tie")
    end
  end
  loop do
    human_choice = ''
    loop do
      human_choice = Kernel.gets().chomp()
      if %w(r p s l ss).include?(human_choice)
        break
      else
        prompt("Enter a valid choice")
      end
    end

    computer_choice = VALID_CHOICES.sample
    prompt("You choose: #{operation(human_choice)}, computer choose: #{computer_choice}")
    results(human_choice, computer_choice)

  prompt("Wins: #{wins}\nLosses: #{losses}\nDraws: #{draws}")
  if wins == 5
    prompt("You won this round")
  elsif losses == 5
    prompt("You loss this round")
  end

  prompt("Do you want to play again?(Y to play again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
  end


prompt("Thank you for playing the game. Hope you have a goodtimes. Goodbye!!")
