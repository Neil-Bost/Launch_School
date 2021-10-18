def prompt(message)
  puts "=> #{message}"
end

# Used in the valid_number? method for checking if the input is a number.
def integer?(num)
  num.to_i.to_s == num
end

# Used in the valid_number? method for checking if the input is a float.
def float?(num)
  num.to_f.to_s == num
end

# Method for checking if the number given by user is valid.
# Allows integers and decimals.
def valid_number?(num)
  integer?(num) || float?(num)
end

def apr_to_monthly_interest(num)
  ((num.to_f / 100) / 12)
end

prompt "Welcome to the Car Loan Calculator!"
=begin # Optional user name entry.
prompt "Please provie your name:"

name = nil
loop do
  name = gets.chomp
  if name.empty?
    prompt "You need to enter a valid name."
  else
    break
  end
end

prompt "Hi there #{name}! Let's get calculating!"
=end
loan_amount = nil
loop do
  prompt "Please provide the total loan amount:"
  loan_amount = gets.chomp
  if valid_number?(loan_amount)
    loan_amount = loan_amount.to_f
    break
  else
    prompt "That number is not valid."
  end
end

apr = nil
loop do
  prompt "Please provide the APR (use x% format):"
  apr = gets.chomp
  if valid_number?(apr)
    break
  else
    prompt "Invalid number."
  end
end

loan_duration = nil
loop do
  prompt "Please provide the loan duration in months:"
  loan_duration = gets.chomp
  if valid_number?(loan_duration)
    loan_duration = loan_duration.to_f
    break
  else
    prompt "That number is not valid."
  end
end

apr = apr_to_monthly_interest(apr)
monthly_payment = loan_amount * (apr / (1 - (1 + apr)**(-loan_duration)))
# My previous solution:
# prompt "Your monthly payment will be $#{monthly_payment.round(2)}"
prompt "Your monthly payment will be $#{format('%.2f', monthly_payment)}"
