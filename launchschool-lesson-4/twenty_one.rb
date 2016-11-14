CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
SUITS = %w(hearts diamonds clubs spades).freeze
DEALER_STAY = 17
MAX_SCORE = 21
wins = 0
losses = 0
ties = 0

def prompt(message)
  puts "=> #{message}"
end

def clear_system
  system('clear') || system('cls')
end

def initialize_deck
  SUITS.product(CARDS).shuffle
end

def calculate_points(hand)
  points = 0
  hand.each do |_suits, value|
    points += if value == "A"
                11
              elsif value.to_i.zero?
                10
              else
                value.to_i
              end
  end
  hand.each do |_suits, value|
    points -= 10 if value == "A" && points > MAX_SCORE
  end
  points
end

def first_draws(card)
  card.shift(2)
end

def draws(card)
  card.shift
end

def busted?(card)
  card > MAX_SCORE
end

def who_won(player, dealer)
  if busted?(player)
    :player_busted
  elsif busted?(dealer)
    :dealer_busted
  elsif player > dealer
    :player_won
  elsif dealer > player
    :dealer_won
  elsif player == dealer
    :ties
  end
end

def game_result(result)
  case result
  when :player_busted then puts "=> Player busted, dealer won!"
  when :dealer_busted then puts "=> Dealer busted, player won!"
  when :player_won then puts "=> Player won!"
  when :dealer_won then puts "=> Dealer won!"
  when :ties then puts "=> It's a tie!"
  end
end

prompt "Welcome to Blackjack table"
prompt "Press enter to play"
gets
clear_system

loop do
  deck = initialize_deck
  player_hand = []
  dealer_hand = []
  player = first_draws(deck)
  dealer = first_draws(deck)
  loop do
    deck = initialize_deck
    player_hand = []
    dealer_hand = []
    player = first_draws(deck)
    dealer = first_draws(deck)
    prompt "Player draw: #{player} for a total of #{calculate_points(player)}"
    prompt "Dealer draw: #{dealer[0, 1]} and a hide card"

    loop do
      prompt "Do you want to hit?(h) to hit or (s) to stay"
      answer = gets.chomp.downcase
      if answer == "h"
        player << draws(deck)
        prompt "Player: #{player} for #{calculate_points(player)}"
      end
      break if answer == "s" || busted?(calculate_points(player))
    end

    loop do
      prompt "Dealer: #{dealer}"
      while calculate_points(dealer) < DEALER_STAY &&
            !busted?(calculate_points(player))
        dealer << draws(deck)
        break if calculate_points(dealer) > DEALER_STAY
      end
      prompt "Dealer have: #{dealer} for #{calculate_points(dealer)}"
      break if who_won(calculate_points(player), calculate_points(dealer))
    end

    loop do
      winner = who_won(calculate_points(player), calculate_points(dealer))
      game_result(winner)
      if winner == :dealer_busted || winner == :player_won
        wins += 1
      elsif winner == :player_busted || winner == :dealer_won
        losses += 1
      elsif winner == :ties
        ties += 1
      end
      break
    end
    prompt "      <><><><><><><><><><>\n\n"
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
    clear_system
  end
  prompt "      <><><><><><><><><><>\n\n"
  prompt "Do you want to play again?(y) or (n)"
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
  clear_system
end
prompt "Thank you for playing 21"
