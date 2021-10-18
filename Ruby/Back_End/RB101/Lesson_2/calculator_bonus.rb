require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message) #method for adding '=>' to every prompt.
  puts "=> #{message}"
end

def integer?(num) # Used in the valid_number? method for checking if the input is a number.
  num.to_i.to_s == num
end

def float?(num) # Used in the valid_number? method for checking if the input is a float.
  num.to_f.to_s == num
end

def valid_number?(num) # Method for checking if the number given by user is valid. Allows integers and decimals.
  integer?(num) || float?(num)
end

def operation_to_message(operation)
operator =  case operation
            when '1' then 'Adding'
            when '2' then 'Subtracting'
            when '3' then 'Multiplying'
            when '4' then 'Dividing'
            end
            operator
end

prompt MESSAGES['welcome']

name = nil
loop do
  name = gets.chomp
  if name.empty?
    prompt MESSAGES['valid_name_error']
  else
    break
  end
end

prompt "Hi there #{name}! Let's get calculating!"

loop do # main loop. checks if user wants to repeat the calculator program.
  first_number = nil
  loop do
    prompt MESSAGES['first_number']
    first_number = gets.chomp
    if valid_number?(first_number)
      break
    else
      prompt MESSAGES['number_error']
    end
  end
  second_number = nil
  loop do
    prompt MESSAGES['second_number']
    second_number = gets.chomp
    if valid_number?(second_number)
      break
    else
      prompt MESSAGES['number_error']
    end
  end
  operator_prompt = <<-MSG
 What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt(operator_prompt)
  operation = nil
  loop do
    operation = gets.chomp
    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt MESSAGES['operation_error']
    end
  end
  prompt("#{operation_to_message(operation)} the two numbers...")
  first_number = first_number.to_f
  second_number = second_number.to_f
  result =  case operation
            when "1" then first_number + second_number
            when "2" then first_number - second_number
            when "3" then first_number * second_number
            when "4" then first_number / second_number
            end
  prompt "The result is #{result}."
  prompt MESSAGES['try_again']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt MESSAGES['last']
