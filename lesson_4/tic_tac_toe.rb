require 'pry'

# These are the markers used by the player and computer.
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

# This is the board used for Tic Tac Toe
def display_board(brd)
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
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

def intialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# Logic used to determine if square is empty.
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# Allows computer to go for the win and defend.
def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

# Determines who goes first or second
def first_or_second
  turn_answer = ''
  loop do
    prompt 'Would you like to go first or second?'
    sleep 1.5
    prompt 'Press [1] to go first and [2] to go second.'
    turn_answer = gets.chomp
    break if turn_answer.downcase.start_with?('1', '2')
    prompt 'That is not a valid answer'
  end
    
  if turn_answer == '1'
    'Player'
  elsif turn_anser == '2'
    'Computer'
  end
end

# allows changing of players
def alternate_player(current_player)
  if current_player == 'Computer'
    'Player'
  elsif current_player == 'Player'
    'Computer'
  end
end

# Adds 'or' at the end of choices unless there is only one choice left.
def joinor(arr, delimiter=', ', word='or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.join(delimiter)
end

# Gives choices of squares and then validates proper square.
def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

# The logic used for the computer to pick a square
def computer_places_piece(brd)
  square = nil
  # offense first choice
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  # defense second choice
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end
  # pick square #5 if available, third choice
  if !square
    square = 5 if brd[5] == INITIAL_MARKER
  end
  # just pick a square last choice
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

# Allows to place piece based on whose turn it is
def place_piece(board, current_player)
  if current_player == 'Player'
    player_places_piece(board)
  elsif current_player == 'Computer'
    computer_places_piece(board)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

loop do
  player_score = 0
  computer_score = 0
  current_player = first_or_second
  loop do
    board = intialize_board

    loop do
      display_board(board)
      place_piece(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    if detect_winner(board) == 'Player'
      prompt "#{detect_winner(board)} won!"
      player_score += 1
    elsif detect_winner(board) == 'Computer'
      prompt "#{detect_winner(board)} won!"
      computer_score += 1
    else
      prompt "It's a tie!"
    end
    prompt "The score is Player: #{player_score} to Computer: #{computer_score}."
    break if player_score == 5 || computer_score == 5
  end
  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
