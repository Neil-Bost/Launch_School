=begin
# 1.
1
2
2
3

# 2.
"!" is a symbol typically used to denote a destructive method. Destructive methods are ones
that mutate the caller on which they are called.
"?" is a symbol typically used to denote method that returns a boolean.
  1. "!=" is the "not equal to" comparison operator, and should be used to
      return a boolean based on whether two object are not equal.
  2. put "!" before an object to return the opposite boolean value.
  3. put "!" after a method invocation to use it desctructively (when possible).
  4. put "?" before ":"" to create a ternary operator of if...else.
  5. put "?" after the letters of certain methods to insure they return a boolean.
  6. put "!!" before a object to return the boolean equivalent of it.

# 3.
advice.gsub!("important", "urgent")

# 4.
numbers.delete_at(1) will delete the element at the second index of the numbers
array, in this case "2".
numbers = [1, 3, 4, 5]
numbers.delete(1) will delete all elements equal to 1.
numbers = [2, 3, 4, 5]

# 5.
puts (10..100).cover?(42)

# 6.
famous_words.insert(0, "Four score and ")
famous_words.prepend("Four score and ")

# 7.
flintstones.flatten!

# 8.
flintstones = flintstones.assoc("Barney")
=end
