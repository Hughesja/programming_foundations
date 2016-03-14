# Writing out a basic flowchart in comments

# Must determine loan amount and APR rate
#  - loan will be float
#  - APR will be float
# Must determine length of loan
#  - will convert loan into months
#  - will ask stand loan time amounts for fix rates
# Will plug loan and APR into formula
#  - will change loan to float here
#  - must turn mortgage into monthly payments
# Return mortage rate in months


def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
    integer?(num) || float?(num)
end

loop do # This is the main loop of the calculator
  
  puts "Welcome to your mortgage calculator!"
  
  loan_amount = ''
  loop do # Loan validation loop
    puts "Please enter your loan amount."
    loan_amount = gets.chomp
    if valid_number?(loan_amount)
      break
    else
     puts "That doesn't seem to be a valid number."
    end
  end

  loan_time = ''
  loop do # Loan choice validation loop
    loan_choice = <<-MSG
      How long will your loan be for?
      1) 30 years
      2) 15 years
      3) 10 years
    MSG
    
    puts loan_choice
    loan_time = gets.chomp
    if %w(1 2 3).include?(loan_time)
      break
    else
      puts "Please choose option 1, 2, or 3."
    end
  end
    loan_time_yrs = case loan_time
                when '1'
                  30
                when '2'
                  15
                when '3'
                  10
                end
  
  # converting loan_time_yrs to months
  loan_time_months = loan_time_yrs.to_f * 12
  
  
  apr = ''
  loop do # This validates the APR % if a valid number
    puts "Please enter your APR. (ex. 5 = 5% APR or 2.5 = 2.5% APR)"
    apr = gets.chomp
    if valid_number?(apr)
      break
    else
      puts "Please enter a valid number."
    end
  end
  # converting APR to monthly interest rate
  monthly_interest = apr.to_f / 12 / 100
  
  puts "Your loan amount is $#{loan_amount} at #{apr}% APR over #{loan_time_yrs} years"
  
  payment = loan_amount.to_f * (monthly_interest.to_f * (1 + monthly_interest.to_f)**loan_time_months.to_f) / ((1 + monthly_interest.to_f)**loan_time_months.to_f - 1)
  
  puts "Your monthly payment would be $#{payment}."
  puts "Would you like to make another calculation? (Y to calculate again)"
  recalculate = gets.chomp
  break unless recalculate.downcase.start_with?('y')
end

puts "Thank you for using the mortgage calculator!"