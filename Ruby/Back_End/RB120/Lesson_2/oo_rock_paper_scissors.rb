class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors #{human.name}. Good bye!"
  end

  def display_winner
    puts "You chose #{human.choice.value}."
    puts "#{computer.name} chose #{computer.choice.value}."

    if human.choice > computer.choice
      puts "You win!"
    elsif computer.choice > human.choice
      puts "#{computer.name} wins!"
    else
      puts "Tie game!"
    end
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

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Choice
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def >(other_choice)
    (value == "rock" && other_choice.value == 'scissors') ||
      (value == 'paper' && other_choice.value == 'rock') ||
      (value == 'scissors' && other_choice.value == 'paper')
  end
end

class Player
  attr_accessor :choice, :name

  def initialize
    set_name
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
      puts "Please choose rock, paper, or scissors:"
      input = gets.chomp
      break if Choice::VALUES.include?(input)
      puts "That is not a valid choice."
    end
    self.choice = Choice.new(input)
  end
end

class Computer < Player
  attr_accessor :choice, :name

  def set_name
    self.name = "Joshua"
  end

  def choose
    self.choice = Choice.new(Choice::VALUES.sample)
  end
end

RPSGame.new.play
