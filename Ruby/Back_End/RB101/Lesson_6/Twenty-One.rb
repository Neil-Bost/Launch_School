def prompt(message)
  puts "#{message}"
end

FRESH_DECK = {
  hearts: { 
  "2 of hearts" => 2,
  "3 of hearts" => 3,
  "4 of hearts" => 4,
  "5 of hearts" => 5,
  "6 of hearts" => 6,
  "7 of hearts" => 7,
  "8 of hearts" => 8,
  "9 of hearts" => 9,
  "10 of hearts" => 10,
  "Jack of hearts" => 10,
  "Queen of hearts" => 10,
  "King of hearts" => 10,
  "Ace of hearts" => 1
  },
  diamonds: {
    "2 of diamonds" => 2,
    "3 of diamonds" => 3,
    "4 of diamonds" => 4,
    "5 of diamonds" => 5,
    "6 of diamonds" => 6,
    "7 of diamonds" => 7,
    "8 of diamonds" => 8,
    "9 of diamonds" => 9,
    "10 of diamonds" => 10,
    "Jack of diamonds" => 10,
    "Queen of diamonds" => 10,
    "King of diamonds" => 10,
    "Ace of diamonds" => 1
  },
  clubs: {
    "2 of clubs" => 2,
    "3 of clubs" => 3,
    "4 of clubs" => 4,
    "5 of clubs" => 5,
    "6 of clubs" => 6,
    "7 of clubs" => 7,
    "8 of clubs" => 8,
    "9 of clubs" => 9,
    "10 of clubs" => 10,
    "Jack of clubs" => 10,
    "Queen of clubs" => 10,
    "King of clubs" => 10,
    "Ace of clubs" => 1
  },
  spades: {
    "2 of spades" => 2,
    "3 of spades" => 3,
    "4 of spades" => 4,
    "5 of spades" => 5,
    "6 of spades" => 6,
    "7 of spades" => 7,
    "8 of spades" => 8,
    "9 of spades" => 9,
    "10 of spades" => 10,
    "Jack of spades" => 10,
    "Queen of spades" => 10,
    "King of spades" => 10,
    "Ace of spades" => 1
  }
}

def initialize_deck
  new_deck = {
    hearts: { 
      "2 of hearts" => 2,
      "3 of hearts" => 3,
      "4 of hearts" => 4,
      "5 of hearts" => 5,
      "6 of hearts" => 6,
      "7 of hearts" => 7,
      "8 of hearts" => 8,
      "9 of hearts" => 9,
      "10 of hearts" => 10,
      "Jack of hearts" => 10,
      "Queen of hearts" => 10,
      "King of hearts" => 10,
      "Ace of hearts" => 1
    },
    diamonds: {
      "2 of diamonds" => 2,
      "3 of diamonds" => 3,
      "4 of diamonds" => 4,
      "5 of diamonds" => 5,
      "6 of diamonds" => 6,
      "7 of diamonds" => 7,
      "8 of diamonds" => 8,
      "9 of diamonds" => 9,
      "10 of diamonds" => 10,
      "Jack of diamonds" => 10,
      "Queen of diamonds" => 10,
      "King of diamonds" => 10,
      "Ace of diamonds" => 1
  },
    clubs: {
      "2 of clubs" => 2,
      "3 of clubs" => 3,
      "4 of clubs" => 4,
      "5 of clubs" => 5,
      "6 of clubs" => 6,
      "7 of clubs" => 7,
      "8 of clubs" => 8,
      "9 of clubs" => 9,
      "10 of clubs" => 10,
      "Jack of clubs" => 10,
      "Queen of clubs" => 10,
      "King of clubs" => 10,
      "Ace of clubs" => 1
    },
    spades: {
      "2 of spades" => 2,
      "3 of spades" => 3,
      "4 of spades" => 4,
      "5 of spades" => 5,
      "6 of spades" => 6,
      "7 of spades" => 7,
      "8 of spades" => 8,
      "9 of spades" => 9,
      "10 of spades" => 10,
      "Jack of spades" => 10,
      "Queen of spades" => 10,
      "King of spades" => 10,
      "Ace of spades" => 1
    }
  }
end

def deal_card!(dck)
  suit = dck.keys.sample
  card = dck[suit].keys.sample
  dck[suit].delete(card)
  card
end

def card_value(card)
  value = nil
  FRESH_DECK.each do |suit, cards|
    value = cards[card] if cards[card]
  end
  value
end

prompt "Welcome to Twenty-One! Let's begin."
deck = initialize_deck

player_cards = {}
dealer_cards = {}

loop do
  loop do
    player_cards[1] = deal_card!(deck)
    player_cards[2] = deal_card!(deck)
    
    dealer_cards[1] = deal_card!(deck)
    dealer_cards[2] = deal_card!(deck)
    
    prompt "The dealer has the following two cards:
    #{dealer_cards[1]}
    unknown card"
    puts
    
    prompt "You are delt the following two cards:
    #{player_cards[1]}
    #{player_cards[2]}"
    puts
  
    player_total = card_value(player_cards[1]) + card_value(player_cards[2])
    dealer_total = card_value(dealer_cards[1]) + card_value(dealer_cards[2])
  
    loop do
      hit_or_stay = nil
      increment = 3
      loop do
        prompt "Would you like to hit or stay?"
        hit_or_stay = gets.chomp.downcase
        break if hit_or_stay == "hit" || hit_or_stay == "stay"
        prompt "Not a valid option."
      end
      
      if hit_or_stay == 'hit'
        prompt "#{player_cards[increment] = deal_card!(deck)}"
        player_total += card_value(player_cards[increment])
        increment += 1
        if player_total > 21
          prompt "Bust! Too bad!"
          break
        end
      else
        break
      end
    end
    
    break if player_total > 21
    
    prompt "The dealer has the following two cards:
    #{dealer_cards[1]}
    #{dealer_cards[2]}"
    puts
    
    i = 3
    loop do
      if dealer_total < 17
        prompt "The dealer hits:"
        prompt dealer_cards[i] = deal_card!(deck)
        dealer_total += card_value(dealer_cards[i])
        i += 1
      elsif dealer_total >= 17 && dealer_total <= 21
        prompt "The dealer's total is #{dealer_total}"
        prompt "The dealer stays."
        break
      else
        prompt "The dealer's total is #{dealer_total}"
        prompt "The dealer busts!"
        break
      end
    end
    
    break if dealer_total > 21
    
    prompt "Your total is: #{player_total}"
    prompt "The dealer's total is: #{dealer_total}"
    if player_total > dealer_total
      prompt "Congratulations! You win!"
      break
    else
      prompt "Dealer wins!"
      break
    end
  end
    again = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      again = gets.chomp
      break if again == 'n' || again == 'y'
      prompt "Invalid input."
    end
    
    break if again == 'n'
end

prompt "Thanks for playing Twenty-One! See ya!"