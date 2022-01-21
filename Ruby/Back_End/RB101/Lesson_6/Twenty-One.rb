# cd Launch_School/Ruby/Back_End/RB101/Lesson_6

require 'pry'
require 'pry-byebug'

SUITS = [" of hearts", " of diamonds", " of clubs", " of spades"]
VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  new_deck = []
  VALUES.product(SUITS) { |num_and_suit| new_deck << num_and_suit.join }
  new_deck.shuffle
end

def total(hand)
  sum = 0
  hand.each do |card|
    if card[0] == "A" # Aces
      sum += 11
    elsif card[0] == "1" || card[0].to_i == 0 # 10s, Jacks, Queens, Kings
      sum += 10
    else # Any 2-9 cards
      sum += card[0].to_i
    end
  end
  ### Revalue Aces if sum > 21
  hand.each { |card| sum -= 10 if card[0] == "A" && sum > 21 } if sum > 21
  sum
end

def compare_results(player, dealer)
  prompt "Your total is #{player}"
  prompt "The dealer's total is #{dealer}"

  if player > dealer
    prompt "Congratulations! You win!"
  else
    prompt "Dealer wins!"
  end
end

prompt "Welcome to Twenty-One! Let's begin."

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []

  loop do
    player_cards << deck.shift
    player_cards << deck.shift

    dealer_cards << deck.shift
    dealer_cards << deck.shift

    prompt "The dealer has the following two cards:"
    puts dealer_cards[0]
    puts "unknown card"
    puts
    dealer_total = total(dealer_cards)

    prompt "You are delt the following two cards:"
    puts player_cards

    player_total = total(player_cards)
    prompt "Your total is #{player_total}"

    ### Player Loop
    loop do
      hit_or_stay = nil
      loop do
        puts
        prompt "Would you like to hit or stay?"
        hit_or_stay = gets.chomp.downcase
        puts
        break if hit_or_stay == "hit" || hit_or_stay == "stay"
        prompt "Not a valid option."
      end

      if hit_or_stay == 'hit'
        player_cards << deck.shift
        puts player_cards

        player_total = total(player_cards)
        prompt "Your total is #{player_total}"

        if player_total > 21
          prompt "Bust! Dealer wins!"
          break
        end
      else # player chose "stay"
        break
      end
    end

    player_total = total(player_cards)
    break if player_total > 21 # skips dealer turn if player busted

    prompt "The dealer has the following two cards:"
    puts dealer_cards
    prompt "The dealers total is #{dealer_total}"
    puts

    ### Dealer Loop
    loop do
      if dealer_total < 17
        prompt "The dealer hits:"
        dealer_cards << deck.shift
        puts dealer_cards
        dealer_total = total(dealer_cards)
        prompt "Dealer's total is #{dealer_total}"
        puts
      elsif dealer_total >= 17 && dealer_total <= 21
        prompt "The dealer stays."
        puts
        break
      else # dealer's total > 21
        prompt "The dealer busts!"
        prompt "You win!"
        break
      end
    end

    dealer_total = total(dealer_cards)
    break if dealer_total > 21

    compare_results(player_total, dealer_total)
    break
  end

  again = nil
  loop do
    prompt "Would you like to play again? (y/n)"
    again = gets.chomp
    break if again == 'n' || again == 'y'
    prompt "Invalid input."
  end

  break if again == 'n'
  system 'clear'
end

prompt "Thanks for playing Twenty-One! See ya!"
