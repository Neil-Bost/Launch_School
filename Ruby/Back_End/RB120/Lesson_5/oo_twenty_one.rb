class Deck
  SUITS = [" of hearts", " of diamonds", " of clubs", " of spades"]
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize
    @deck = []
    VALUES.product(SUITS) { |num_and_suit| @deck << num_and_suit.join }
    shuffle_cards!
  end

  def deal_card!
    @deck.pop
  end

  private

  def shuffle_cards!
    @deck.shuffle!
  end
end

class Participant
  attr_accessor :name
  attr_reader :hand

  def initialize
    @name = nil
    @hand = []
  end

  def add_card(card)
    @hand << card
  end

  def busted?
    total > 21
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def total
    total = 0
    hand.each do |card|
      if card[0] == "A"                         # Aces
        total += 11
      elsif card[0] == "1" || card[0].to_i == 0 # 10s, Jacks, Queens, Kings
        total += 10
      else                                      # Any 2-9 cards
        total += card[0].to_i
      end
    end

    # revalue Aces if necessary
    hand.select { |card| card[0] == "A" }.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset
    @hand = []
  end
end

class TwentyOne
  def initialize
    @player = Participant.new
    @dealer = Participant.new
  end

  def play
    display_welcome_message
    choose_name
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      new_game
      deal_starting_hand
      display_starting_hand
      player_turn
      dealer_turn unless @player.busted?
      display_result
      break unless play_again?
      clear
    end
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def choose_name
    @dealer.name = "The dealer"
    puts "Please enter your name:"
    loop do
      @player.name = gets.chomp
      break unless @player.name == ""
      puts 'Please enter a name.'
    end
    clear
    puts "Hello #{@player.name}! Let's begin!"
  end

  def new_game
    @player.reset
    @dealer.reset
    @deck = Deck.new
  end

  def deal_starting_hand
    2.times do
      @dealer.add_card(@deck.deal_card!)
      @player.add_card(@deck.deal_card!)
    end
  end

  def display_starting_hand
    @player.total
    puts "#{@dealer.name} is delt the following two cards:"
    puts
    puts "---#{@dealer.name}'s hand---"
    puts @dealer.hand.first
    puts "facedown card"
    puts
    puts "#{@player.name} is delt the following two cards:"
    puts
    display_hand(@player)
  end

  def player_turn
    loop do
      puts "Do you want to hit or stay?"
      hit_or_stay == "hit" ? @player.add_card(@deck.deal_card!) : break
      clear
      display_hand(@player)
      break if @player.busted?
    end
  end

  def hit_or_stay
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(hit stay).include?(answer)
      puts "Invalid entry."
    end
    answer
  end

  # rubocop:disable Metrics/MethodLength
  def dealer_turn
    clear
    display_hand(@dealer)
    loop do
      if @dealer.total < 17
        puts "#{@dealer.name} hits."
        puts
        @dealer.add_card(@deck.deal_card!)
        display_hand(@dealer)
      else
        puts "#{@dealer.name} stays."
        puts
        break
      end
      break if @dealer.busted?
    end
  end
  # rubocop:enable Metrics/MethodLength

  def display_hand(participant)
    participant.total
    puts "---#{participant.name}'s hand---"
    puts participant.hand
    puts "Total: #{participant.total}"
    puts
  end

  def display_result
    if @player.busted? || @dealer.busted?
      show_busted
    else
      puts "#{@dealer.name}'s total: #{@dealer.total}."
      puts "#{@player.name}'s total: #{@player.total}."
      puts
      winner? ? display_winner : (puts "Tie game!")
    end
  end

  def show_busted
    if @player.total > 21
      puts "#{@player.name} busted!"
      puts "#{@dealer.name} wins!"
    else
      puts "#{@dealer.name} busted!"
      puts "#{@player.name} wins!"
    end
  end

  def winner?
    @player.total > @dealer.total || @dealer.total > @player.total
  end

  def display_winner
    if @player.total > @dealer.total
      puts "#{@player.name} wins!"
    else
      puts "#{@dealer.name} wins!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One! Bye!"
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
end

TwentyOne.new.play
