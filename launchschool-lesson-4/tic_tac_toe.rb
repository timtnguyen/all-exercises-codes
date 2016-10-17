require 'pry'

INITIAL_MARKER = " ".freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
WINNING_COMBO = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]].freeze       # diagnals

wins = losses = draws = 0

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Method/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are: #{PLAYER_MARKER}, Computer is: #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Method/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def first_move
  loop do
    prompt "Enter 'p' to go first or 'c' for computer to go first"
    answer = gets.chomp.downcase
    if answer.start_with?('p')
      return "player"
    elsif answer.start_with?('c')
      return "computer"
    else
      prompt "Enter a valid choice"
    end
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(element, operator = ", ", conj = "or ")
  last_num = element.slice!(-1)
  "(#{element.join(operator)}" + ", " + "#{conj}#{last_num})"
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square " + joinor(empty_squares(brd)) + ":"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice"
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_calculation(brd)
  moves = {}
  WINNING_COMBO.each do |line|
    if imediate_threat?(brd, line)
      moves['offense'] = line.find { |square| brd[square] == INITIAL_MARKER }
    elsif opportunity?(brd, line)
      moves['offense'] = line.find { |square| brd[square] == INITIAL_MARKER }
    end
  end
  moves
end

def imediate_threat?(brd, line)
  brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
end

def opportunity?(brd, line)
  brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
end

def computer_places_piece!(brd)
  square = if computer_calculation(brd).key?('offense')
             computer_calculation(brd)['offense']
           elsif computer_calculation(brd).key?('defense')
             computer_calculation(brd)['defense']
           elsif empty_squares(brd).include?(5)
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_COMBO.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

def make_move!(brd, current_player)
  if current_player == "player"
    player_places_piece!(brd)
  elsif current_player == "computer"
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  if current_player == "player"
    "computer"
  elsif current_player == "computer"
    "player"
  end
end

loop do
  board = initialize_board
  current_player = first_move
  loop do
    display_board(board)
    make_move!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)
  if someone_won?(board)
    prompt "#{detect_winner(board)} won!\n\n"
  else
    prompt "It's a tie!\n\n"
  end

  if detect_winner(board) == "Player"
    wins += 1
  elsif detect_winner(board) == "Computer"
    losses += 1
  else
    draws += 1
  end

  prompt "SCORE:"
  prompt "Player wins:#{wins} => Computer wins:#{losses} => Draws:#{draws}\n\n"

  if wins == 5
    prompt "You won this round!"
    break
  elsif losses == 5
    prompt "Computer won this round!"
    break
  end

  prompt "Do you want to play again?(y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank for playing tic tac toe. Goodbye!"
