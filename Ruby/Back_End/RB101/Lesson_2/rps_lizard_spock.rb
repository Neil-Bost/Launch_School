VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'Spock',
                 'r', 'p', 's', 'l', 'S']
CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'Spock']

player_moves = {  "rock" => ["scissors", "s", "lizard", "l"],
                  "paper" => ["Spock", "S", "rock", "r"],
                  "scissors" => ["lizard", "l", "paper", "p"],
                  "lizard" => ["Spock", "S", "paper", "p"],
                  "Spock" => ["scissors", "s", "rock", "r"] }

def prompt(message)
  puts "=> #{message}"
end

loop do
  player_score = 0
  computer_score = 0
  tie = 0

  loop do
    player = ''

    loop do
      prompt("Choose one: #{[CHOICES].join(', ')}")
      player = gets.chomp

      if VALID_CHOICES.include?(player)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    # The following block reassigns any single letter inputs to the full word,
    # so that when the program displays what the user chose it will be the word
    # not the single letter. This also allows us to remove the single letter
    # keys from the hash.
    player = "rock" if player == "r"
    player = "paper" if player == 'p'
    player = "scissors" if player == 's'
    player = "lizard" if player == "l"
    player = "Spock" if player == "S"

    computer = CHOICES.sample

    prompt("You chose #{player}, the computer chose #{computer}.")

    if player_moves[player] && player_moves[player].include?(computer)
      prompt("You win!")
      player_score += 1
    elsif player_moves[computer] && player_moves[computer].include?(player)
      prompt("You lose!")
      computer_score += 1
    else
      prompt("Tie!")
      tie += 1
    end

    break if player_score == 3 || computer_score == 3

    prompt("The current score is " \
    "wins: #{player_score}, ties: #{tie}, loses: #{computer_score}")
  end

  if player_score > computer_score
    prompt("The match is over! You win!")
  else
    prompt("The match is over! You lose!")
  end

  prompt("The final score was " \
  "wins: #{player_score}, ties: #{tie}, loses: #{computer_score}.")
  prompt("Do you want to play again?")
  answer = gets.chomp

  break unless (answer.downcase == 'y') || (answer.downcase == 'yes') ||
               (answer.downcase == 'yes!')
end

prompt("Thanks for playing! Bye!")
