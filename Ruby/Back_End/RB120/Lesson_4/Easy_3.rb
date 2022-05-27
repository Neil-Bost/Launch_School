=begin
# Question 1
case 1:
`"Hello"` is output.

case 2:
An exception is raised: NoMethod error

case 3:
An exception is raised: Wrong number of arguments error, expected 1, given 0.

case 4:
`"Goodbye"` is output.

case 5:
An exception is raised: NoMethod error

# Question 2
We could either call Hello.new.hi(""), or we could define a new method in the 
Hello class:
def self.hi
  # code
end

# Question 3
cat1 = AngryCat.new(5, "Chucho")
cat2 = AngryCat.new(6, "Bella")

# Question 4
We could create a new method inside the `Cat` class called `to_s`. This will override
the default `to_s` method that is called on the `Cat` objects.

def to_s
  puts "I am a #{@type} cat"
end

# Question 5
tv = Television.new
tv.manufacturer #=> This will raise the exception NoMethod error, because the `manufacturer
method is a class method, and is not available to instances of the class.

tv.model #=> This is execute the code inside the `model` method.

Television.manufacturer #=> This will excecute the code inside the `manufacturer` method.
Television.model #=> This will raise the exception NoMethod error, because the `model`
method is an instance method, not a class method.

# Question 6
Use `@` instead of `self`.

# Question 7
The `self.information` method does not add any value. It doesn't use the instance
variables that the user has the option to define, so the code is not dynamic.
=end
