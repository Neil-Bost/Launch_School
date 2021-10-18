def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(operation)
  case operation
  when '1' then 'Adding'
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt "Welcome to the calculator! Please enter your name:"

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

loop do # main loop. checks if user wants to repeat the calculator program.
  first_number = nil
  loop do
    prompt "Please provide the first number:"
    first_number = gets.chomp
    if valid_number?(first_number)
      break
    else
      prompt "That was not a number."
    end
  end
  second_number = nil
  loop do
    prompt "Please provide the second number:"
    second_number = gets.chomp
    if valid_number?(second_number)
      break
    else
      prompt "That was not a number."
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
      prompt "You must choose a number from 1-4."
    end
  end
  prompt("#{operation_to_message(operation)} the two numbers...")
  result =  case operation
            when "1" then first_number.to_i + second_number.to_i
            when "2" then first_number.to_i - second_number.to_i
            when "3" then first_number.to_i * second_number.to_i
            when "4" then first_number.to_f / second_number.to_f
            end
  prompt "The result is #{result}."
  prompt "Do you want to perform another calculation? (y to calculate again)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for calculating with the calculator! Come again soon!"
