require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diaganols

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts ""
  puts "  1  |  2  |  3  "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "  4  |  5  |  6  "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "  7  |  8  |  9  "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(choices, punctuation = ', ', conjuction = 'or')
  empties = ""
  choices.each do |num|
    if choices.last == num
      empties << conjuction + ' ' + num.to_s
    else
      empties << num.to_s + punctuation
    end
  end
  empties.delete!(',') if choices.size == 2
  empties
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose an empty square to place your X (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    puts "Sorry, that is not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def strategic_placement(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1
    line.select { |num| brd[num] == INITIAL_MARKER }.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = strategic_placement(brd, line, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = strategic_placement(brd, line, PLAYER_MARKER)
      break if square
    end
  end

  square = 5 if !square unless brd[5] != INITIAL_MARKER

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count('X') == 3
      return 'Player'
    elsif brd.values_at(line[0], line[1], line[2]).count('O') == 3
      return 'Computer'
    end
  end
  nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def place_piece!(brd, curr_playr)
  player_places_piece!(brd) if curr_playr == 'Player'
  computer_places_piece!(brd) if curr_playr == 'Computer'
end

def alternate_player(curr_playr)
  return 'Player' if curr_playr == 'Computer'
  return 'Computer' if curr_playr == 'Player'
end

player_score = 0
computer_score = 0
tie = 0
board = initialize_board
first_player = nil

### Player chooses who goes first.
loop do
  prompt "Welcome to Tic Tac Toe! First to five points wins the game!"
  prompt "Who do you want to go first? (player or computer)"
  first_player = gets.chomp.capitalize
  break if first_player == 'Player' ||
            first_player == 'Computer'
  prompt "Invalid option."
end

### Computer chooses who goes first.
# prompt "Welcome to Tic Tac Toe! First to five points wins the game!"
# first_player = %w(Player Computer).sample
# prompt "#{first_player} goes first!"

loop do
  prompt "Are you ready? (y/n)"
  ready = gets.chomp
  break if ready == 'y'
end

loop do
  current_player = first_player
  board = initialize_board

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won this round!"
  else
    prompt "This round ends in a tie!"
  end

  if detect_winner(board) == 'Player'
    player_score += 1
  elsif detect_winner(board) == 'Computer'
    computer_score += 1
  else
    tie += 1
  end

  break if player_score >= 5 || computer_score >= 5

  puts
  prompt "The current score is:"
  prompt "Player: #{player_score}"
  prompt "Computer: #{computer_score}"
  prompt "tie: #{tie}"

  prompt "Would you like to keep going? (y/n)"
  answer = gets.chomp
  break if answer == 'n'
end

display_board(board)

if player_score >= 5
  prompt "Congratulations! You Win!"
elsif computer_score >= 5
  prompt "Aw, too bad. Better luck next time!"
end

prompt "The final score is:"
prompt "Player: #{player_score}"
prompt "Computer: #{computer_score}"
prompt "tie: #{tie}"
prompt "Thanks for playing Tic Tac Toe! Bye!"
