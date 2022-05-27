=begin
# Question 1
All of these are objects.
Use the method #class.

# Question 2
Add the line `include Speed` to both the Car and Truck class.
Running the code `Car.new.go_fast` should return the string in the `go_fast` method.

# Question 3
The code `self.class` in the `Speed` module calls the `#class` method on the calling
object, which returns the class of which the object is a member. If we define a new
car object of the `Car` class and call `self.class` on it, `Car` will be returned.

# Question 4
AngryCat.new

# Question 5
`Pizza`, because the symbol `@` before a variable name denotes an instance variable.

# Question 6
attr_reader :volume

# Question 7
The default return value is a string representation of the object on which it is
called. It includes the class followed by an encoding of the object id.
You can check the documentation of the #to_s method under the Object class.

# Question 8
It refers to the calling object.

# Question 9
It refers to the calling class, `Cat`.

# Question 10
We would need to call `Bag.new()` and pass in two arguements, the first for the
color and the second for the material. example:
Bag.new("red", "leather")
=end
