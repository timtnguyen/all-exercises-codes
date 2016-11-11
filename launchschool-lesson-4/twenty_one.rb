require 'pry'

CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'] +
        ['A'].freeze
SUITS = ['hearts', 'diamonds', 'clubs', 'spades'].freeze
DEALER_STAY = 17
MAX_SCORE = 21
wins = 0
losses = 0
ties = 0

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  SUITS.product(CARDS).shuffle
end

def calculate_points(hand)
  points = 0
  hand.each do |card|
    points += if card[1] == "A"
                11
              elsif card[1].to_i.zero?
                10
              else
                card[1].to_i
              end
  end
  hand.each do |card|
    points -= 10 if card[1] == "A" && points > MAX_SCORE
  end
  points
end

def first_draws(card)
  card.shift(2)
end

def display_player_hand(player)
  if player.empty?
    player << first_draws(initialize_deck)
  end
  player.flatten(1)
end

def display_dealer_hand(dealer)
  if dealer.empty?
    dealer << first_draws(initialize_deck)
  end
  dealer.flatten(1)
end

def draws(card)
  card.shift
end

def player_draws(card)
  card << draws(initialize_deck)
end

def dealer_draws(card, total)
  if total < DEALER_STAY
    card << draws(initialize_deck)
  end
end

def busted?(card)
  card > MAX_SCORE
end

def who_won?(player, dealer)
  if busted?(player)
    "Player busted, dealer won!"
  elsif busted?(dealer)
    "Dealer busted, player won!"
  elsif player > dealer
    "Player won!"
  elsif dealer > player
    "Dealer won!"
  elsif player == dealer
    "It's a tie!"
  end
end

prompt "Welcome to Blackjack table"
prompt "Press enter to play"
gets
loop do
  player_hand = []
  dealer_hand = []
  player = display_player_hand(player_hand)
  dealer = display_dealer_hand(dealer_hand)
  loop do
    player_hand = []
    dealer_hand = []
    player = display_player_hand(player_hand)
    dealer = display_dealer_hand(dealer_hand)
    prompt "Player draw: #{player} for a total of #{calculate_points(player)}"
    prompt "Dealer draw: #{dealer[0, 1]} and a hide card"

    loop do
      prompt "Do you want to hit?(h) to hit or (s) to stay"
      answer = gets.chomp.downcase
      if answer == "h"
        player << draws(initialize_deck)
        prompt "Player: #{player} for #{calculate_points(player)}"
      end
      break if answer == "s" || busted?(calculate_points(player))
    end

    loop do
      prompt "Dealer: #{dealer}"
      while calculate_points(dealer) < DEALER_STAY &&
            !busted?(calculate_points(player))
        dealer << draws(initialize_deck)
        if calculate_points(dealer) > DEALER_STAY
          break
        end
      end
      prompt "Dealer have: #{dealer} for #{calculate_points(dealer)}"
      break if who_won?(calculate_points(player), calculate_points(dealer))
      break
    end

    prompt who_won?(calculate_points(player), calculate_points(dealer)).to_s
    loop do
      count_wins = who_won?(calculate_points(player), calculate_points(dealer))
      if count_wins == "Dealer busted, player won!" ||
         count_wins == "Player won!"
        wins += 1
      elsif count_wins == "Player busted, dealer won!" ||
            count_wins == "Dealer won!"
        losses += 1
      elsif count_wins == "It's a tie!"
        ties += 1
      end
      break
    end
    prompt "      <><><><><><><><><><>"
    total_count = "Player: #{wins} => Dealer: #{losses} => Draws: #{ties}"
    prompt total_count.to_s
    if wins == 5
      prompt "Player won this round!"
      wins = losses = ties = 0
      break
    elsif losses == 5
      prompt "Dealer won this round!"
      wins = losses = ties = 0
      break
    end
    prompt "Press enter to play again"
    gets
  end
  prompt "      <><><><><><><><><><>"
  prompt "Do you want to play again?(y) or (n)"
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end
prompt "Thank you for playing 21"
