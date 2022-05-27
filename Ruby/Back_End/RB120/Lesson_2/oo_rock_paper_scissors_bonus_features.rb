class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hello #{human.name}! Welcome to Rock, Paper, Scissors!"
    puts "The first player to win 10 rounds wins the game!"
  end

  def display_goodbye_message
    puts "The choices made by each player were:"
    puts "#{human.name}'s choices"
    human.history
    puts "#{computer.name}'s choices"
    computer.history
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock! " + \
    "Good bye #{human.name}!"
  end

  def display_choices
    puts "You chose #{human.choice.value}."
    puts "#{computer.name} chose #{computer.choice.value}."
  end

  def display_round_winner
    if human.choice > computer.choice
      puts "You win the round!"
      human.score += 1
    elsif computer.choice > human.choice
      puts "#{computer.name} wins the round!"
      computer.score += 1
    else
      puts "Tie game!"
    end
  end

  def display_game_winner
    if human.score > computer.score
      puts "You win the game!"
    else
      puts "#{computer.name} wins the game!"
    end
  end

  def display_score
    puts "The score is:"
    puts "  #{human.name}: #{human.score}"
    puts "  #{computer.name}: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if answer == "y" || answer == "n"
      puts "Invalid input. Please enter either 'y' or 'n'."
    end
    answer == 'y'
  end

  def reset_scores!
    human.score = 0
    computer.score = 0
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_choices
        display_round_winner
        display_score
        break if human.score >= 10 || computer.score >= 10
      end

      display_game_winner
      break unless play_again?
      reset_scores!
    end
    display_goodbye_message
  end
end

class Choice
  attr_reader :value

  VALUES = { "rock" => ["scissors", "lizard"],
             "paper" => ["Spock", "rock"],
             "scissors" => ["lizard", "paper"],
             "lizard" => ["Spock", "paper"],
             "Spock" => ["scissors", "rock"] }

  def initialize(value)
    @value = value
  end

  def >(other_choice)
    VALUES[value].include?(other_choice.value)
  end
end

class Player
  attr_accessor :choice, :name, :score
  attr_writer :history

  def initialize
    set_name
    @score = 0
    @history = { "rock" => 0, 
                 "paper" => 0, 
                 "scissors" => 0, 
                 "lizard" => 0, 
                 "Spock" => 0 }
  end
  
  def history
    @history.each_pair do |choice, number|
      puts "#{choice}: #{number}"
    end
  end
end

class Human < Player
  def set_name
    user_name = ""
    loop do
      puts "Please enter your name:"
      user_name = gets.chomp
      break unless user_name.empty?
      puts "You gotta give me something."
    end
    self.name = user_name
  end

  def choose
    input = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or Spock:"
      input = gets.chomp
      break if Choice::VALUES.include?(input)
      puts "That is not a valid choice."
    end
    self.choice = Choice.new(input)
    @history[choice.value] += 1
  end
end

class Computer < Player
  def set_name
    self.name = "Joshua"
  end

  def choose
    self.choice = Choice.new(Choice::VALUES.keys.sample)
    @history[choice.value] += 1
  end
end

RPSGame.new.play
