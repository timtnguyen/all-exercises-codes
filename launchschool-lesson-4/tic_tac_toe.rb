require 'pry'

PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
INITIAL_MARKER = " ".freeze
WINNING_COMBO = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15],
                 [16, 17, 18, 19, 20], [21, 22, 23, 24, 25]] +   # rows
                [[1, 6, 11, 16, 21], [2, 7, 12, 17, 22], [3, 8, 13, 18, 23],
                 [4, 9, 14, 19, 24], [5, 10, 15, 20, 25]] +      # columns
                [[1,  7, 13, 19, 25], [5, 9, 13, 17, 21]].freeze # diagnals

wins = losses = draws = 0

def prompt(message)
  puts " => #{message}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are: #{PLAYER_MARKER}, Computer is: #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     |     |" + "          (1 | 2 | 3 | 4 | 5)"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  | #{brd[4]}   |  #{brd[5]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |" + "          (6 | 7 | 8 | 9 | 10)"
  puts "  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  |  #{brd[10]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |" + "          (11 | 12 | 13 | 14 | 15)"
  puts "  #{brd[11]}  |  #{brd[12]}  |  #{brd[13]}  |  #{brd[14]}  | #{brd[15]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |" + "          (16 | 17 | 18 | 19 | 20)"
  puts "  #{brd[16]}  |  #{brd[17]}  |  #{brd[18]}  |  #{brd[19]}  | #{brd[20]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |" + "          (21 | 22 | 23 | 24 | 25)"
  puts "  #{brd[21]}  |  #{brd[22]}  |  #{brd[23]}  |  #{brd[24]}  | #{brd[25]}"
  puts "     |     |     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..25).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def pick_turn
  loop do
    prompt "First to wins 5 will win the round"
    prompt "Choose turn: enter 'p' to go first or 'c' for computer go first"
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

def joinor(element, operator = ", ", conj = " or ")
  small_arr = element.slice!(-1)
  "(#{element.join(operator)}" + "#{conj}#{small_arr})"
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose one:" + joinor(empty_squares(brd)) + ":"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Enter valid choice"
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = if detect_move(brd).key?('offense')
             detect_move(brd)['offense']
           elsif detect_move(brd).key?('defense')
             detect_move(brd)['defense']
           elsif empty_squares(brd).include?(19)
             19
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
    if brd.values_at(*line).count(PLAYER_MARKER) == 5
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 5
      return "Computer"
    end
  end
  nil
end

def threat?(brd, line)
  (brd.values_at(*line).count(PLAYER_MARKER) == 3 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 2) ||
    (brd.values_at(*line).count(PLAYER_MARKER) == 4 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1)
end

def opportunity?(brd, line)
  (brd.values_at(*line).count(COMPUTER_MARKER) == 3 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 2) ||
    (brd.values_at(*line).count(COMPUTER_MARKER) == 4 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1)
end

def detect_move(brd)
  moves = {}
  WINNING_COMBO.each do |line|
    if opportunity?(brd, line)
      moves['offense'] = line.find { |square| brd[square] == INITIAL_MARKER }
    elsif threat?(brd, line)
      moves['defense'] = line.find { |square| brd[square] == INITIAL_MARKER }
    end
  end
  moves
end

def make_moves(brd, current_player)
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
  current_player = pick_turn

  loop do
    display_board(board)
    make_moves(board, current_player)
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

  prompt "SCORE:\n\n"

  prompt "Player wins: #{wins} => Computer wins: #{losses} => Draws: #{draws}\n"

  if wins == 5
    prompt "Player won this round!\n\n"
    break
  elsif losses == 5
    prompt "Computer won this round!\n\n"
    break
  end

  prompt "Do you want to play again?(y or n)"
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt "Thank you for playing tic-tac-toe. Goodbye"
