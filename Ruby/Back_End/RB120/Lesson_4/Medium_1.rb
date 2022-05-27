=begin
# Question 1
Ben, because the `attr_reader :balance` creates a getter method called `balance`
that can be used to return the `@balance` instance variable.

# Question 2
The mistake is on line 11 when `quantity =` is called. This code is attempting to
reassign the  `@quality` isntance variable by using the `quality=()` method, which has
not been defined via a manual setter method or the `attr_writer`/`attr_accessor`
methods. This code is actually initializing a local variable called `quanitity`, which
is almost certainly not what we want. There are a few ways to address this.
1. We can add a `@` in front of `quantity` on line 11 so that the code will reassign
the instance variable `@quantity`.
2. We can add `attr_accessor :quantity`, then add `self` in front of `quantity` on line 11.

# Question 3
One problem with this fix is that it allows us to change the `@product_name` and
`@quantity` variables directly, without having to use the `update_quantity()` method.
If we wanted to restrict access to writing privelages through this method, we wouldn't
want to use `attr_accessor`.

# Question 4
class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Question 5
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @filling_type = "Plain" if filling_type == nil
    @glazing = glazing
  end
  
  def to_s
    @glazing == nil ? "#{@filling_type}" : "#{@filling_type} with #{@glazing}"
  end
end

# Question 6
There is no difference.

# Question 7
`status`
=end
