require 'pry'
require 'pry-byebug'

class Board
  ROWS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  COLUMNS = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  DIAGONALS = [[1, 5, 9], [3, 5, 7]]
  WINNING_LINES = ROWS + COLUMNS + DIAGONALS

  attr_reader :unmarked_squares

  def initialize
    @squares = {}
    @crucial_line = nil
    reset
  end

  def []=(square, marker)
    @squares[square].marker = marker
    remove_square_choice!(square)
  end

  def full?
    unmarked_squares.empty?
  end

  def round_winner?(player)
    WINNING_LINES.each do |line|
      if line.all? { |num| player.selected_squares.include?(num) }
      # if line.all? do |num|
      #   binding.pry
      #   player.selected_squares.include?(num)
      # end
        return true
      end
    end
    false
  end

  def imminent_ending?(marker)
    WINNING_LINES.each do |line|
      if line.count { |square| @squares[square].marker == marker } == 2 &&
        line.any? { |square| @squares[square].marker == Square::INITIAL_MARKER }
        @crucial_line = line
        return true
      end
    end
    false
  end

  def square_5_open?
    @squares[5].marker == Square::INITIAL_MARKER
  end

  def find_crucial_square
    @crucial_line.select do |square|
      @squares[square].marker == Square::INITIAL_MARKER
    end[0]
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
    @unmarked_squares = @squares.keys
    @crucial_line = nil
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '  1     2     3  '
    puts '     |     |     '
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts '     |     |     '
    puts '--4--+--5--+--6--'
    puts '     |     |     '
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts '     |     |     '
    puts '--7--+--8--+--9--'
    puts '     |     |     '
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts '     |     |     '
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def remove_square_choice!(square)
    unmarked_squares.delete(square)
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_accessor :score, :name, :marker
  attr_reader :winner, :selected_squares

  def initialize
    @name = ""
    @marker = ""
    @selected_squares = []
    @winner = false
    @score = 0
  end

  def player_wins
    @winner = true
    @score += 1
  end

  def select_square(square)
    @selected_squares << square
  end

  def reset
    @selected_squares = []
    @winner = false
  end
end

class TicTacToeGame
  WINNING_SCORE = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @first_player = nil
    @current_player = nil
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def choose_starting_options
    puts "Please enter your name:"
    choose_name(human)

    puts "Thanks #{human.name}! Now please enter a name for the computer:"
    choose_name(computer)
    puts "The computer's name is #{computer.name}."

    puts "Now please choose which marker you'd like to use. (X or O)"
    choose_markers
    puts "You chose #{human.marker}."

    puts "Would you like to go first? (y/n)"
    choose_player_order

    puts "#{human.name} versus #{computer.name}! First player to 5 wins!" + \
    "Let's play!"
  end

  def choose_name(player)
    loop do
      player.name = gets.chomp
      break unless player.name == ""
      puts 'Please enter a name.'
    end
  end

  def choose_markers
    choice = nil
    loop do
      choice = gets.chomp.upcase
      break if %w(X O).include?(choice)
      puts "Please choose 'X' or 'O'."
    end
    human.marker = choice
    human.marker == 'X' ? computer.marker = 'O' : computer.marker = 'X'
  end

  def choose_player_order
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
    end
    answer == "y" ? @first_player = human : @first_player = computer
    @current_player = @first_player
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're #{human.marker}, the computer is #{computer.marker}."
    board.draw
    puts
  end

  def display_choices
    choices = board.unmarked_squares.join(', ')
    choices[-3] = " or" if choices.size > 1
    choices
  end

  def human_moves
    square = nil
    loop do
      puts "Choose an empty square: #{display_choices}"
      square = gets.chomp.to_i
      break if board.unmarked_squares.include?(square)
      puts 'Invalid entry.'
    end

    board[square] = human.marker
    human.select_square(square)
  end

  def computer_moves
    square =  if board.imminent_ending?(computer.marker) # imminent victory?
                board.find_crucial_square
              elsif board.imminent_ending?(human.marker) # imminent defeat?
                board.find_crucial_square
              elsif board.square_5_open?
                5
              else
                board.unmarked_squares.sample
              end
    board[square] = computer.marker
    computer.select_square(square)
  end

  def current_player_moves
    @current_player == human ? human_moves : computer_moves
  end

  def switch_current_player
    @current_player = @current_player == human ? computer : human
  end

  def players_move
    loop do
      current_player_moves
      if board.round_winner?(@current_player)
        @current_player.player_wins
        break
      end
      break if board.full?
      switch_current_player
      clear_screen_and_display_board
    end
  end

  def game_winner?
    human.score >= WINNING_SCORE || computer.score >= WINNING_SCORE
  end

  def main_game
    choose_starting_options
    loop do
      loop do
        display_board
        players_move
        display_result
        break if game_winner?
        new_game
      end

      display_winner
      break unless play_again?
      display_play_again_message
      new_game
      reset_scores
    end
  end

  def display_result
    clear_screen_and_display_board

    if human.winner
      puts 'You won!'
    else
      computer.winner ? (puts 'The computer won!') : (puts 'Tie game!')
    end

    puts 'The score is:'
    puts "You: #{human.score}"
    puts "Computer: #{computer.score}"
    puts
  end

  def display_winner
    if human.score >= WINNING_SCORE
      puts 'Congratulations! You won!'
    else
      puts 'The computer won. Better luck next time!'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? ('y' or 'n')"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)

      puts 'Invalid input.'
    end

    answer == 'y'
  end

  def display_play_again_message
    clear
    puts "Let's play again!"
  end

  def new_game
    board.reset
    human.reset
    computer.reset
    @current_player = @first_player
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end
end

game = TicTacToeGame.new
game.play
