=begin
# 1.
### Original Answer
flintstones = "The Flintstones Rock!"
indent = flintstones.length - 1

10.times { puts flintstones.rjust(indent += 1)}

### Second Try
10.times { |x| puts " " * x + "The Flinstones Rock!" }


# 2.
You cannot concatenate a string with an integer.
  1) You could convert the integer to a string:
      puts "the value of 40 + 2 is " + (40 + 2).to_s
  2) You could use string interlopation to insert the equation:
      puts "the value of 40 + 2 is #{40 + 2}."


# 3.
def factors(number)
  divisor = number
  factors = []

  number.times do |n|
    n += 1
    factors << number / n if 10 % n == 0
  end
  
  factors
end

### Bonus 1
The purpose is to find the numbers that are factors of the given number. A
number is a factor of a number if it divides evenly into (has a remainder of 0).

### Bonus 2
The purpose of this line is to establish the array of factors as the return
value of the method. Without this, the return value would be the last line
executed.


# 4.
Yes: the push operator (<<) mutates the caller destructively, while the 
concatenation operator (+) does not.


# 5.
The "fib" method has a self contained scope that cannot access the "limit"
variable, which is in the outer scope.
You could put the limit variable inside the "fib" method. You could also pass a
third argument into the method that could set a custom limit every time.


# 6.
34


# 7.


# 8.
"paper"


# 9.
"no"

=end
