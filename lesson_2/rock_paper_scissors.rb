VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  puts "=> #{message}"
end

# This is the rules for the game
def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'spock' && (second == 'scissors' || second == 'rock')) ||
    (first == 'lizard' && (second == 'paper' || second == 'spock'))
end

def display_results(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
end

# Main loop of program
loop do
  user_score = 0
  computer_score = 0
  loop do
    choice = ''
    loop do
      prompt "Choose one: (R)ock, (P)aper, (SC)issors, (L)izard, or (SP)ock"
      choice = gets.chomp

      # Allows user to use short form to get proper choice
      choice = case
               when choice.downcase.start_with?('r') || choice == 'rock'
                 choice = 'rock'
               when choice.downcase.start_with?('p') || choice == 'paper'
                 choice = 'paper'
               when choice.downcase.start_with?('sc') || choice == 'scissors'
                 choice = 'scissors'
               when choice.downcase.start_with?('l') || choice == 'lizard'
                 choice = 'lizard'
               when choice.downcase.start_with?('sp') || choice == 'spock'
                 choice = 'spock'
               end

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt "That's not a valid choice."
      end
    end

    computer_choice = VALID_CHOICES.sample

    puts "You choose: #{choice}; Computer chose: #{computer_choice}."

    display_results(choice, computer_choice)

    # Games won counter
    if win?(choice, computer_choice)
      user_score += 1
    elsif win?(computer_choice, choice)
      computer_score += 1
    end

    if user_score == 5
      prompt 'You have won the match!'
    elsif computer_score == 5
      prompt 'Computer has won the match!'
    end

    # Breaks when someone reach a total of 5 wins
    break unless user_score < 5 && computer_score < 5
    prompt "You have won #{user_score} time(s) and the computer has won #{computer_score} time(s)."
  end

  prompt "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Good bye!"
