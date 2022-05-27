=begin
# Question 1
Running the code will return `"You will "` followed by a random selecting of
the array in the `choices` method.

# Question 2
Running the code will return `"You will "` followed by a random selecting of
the array in the `choices` method of the `RoadTrip` class.

# Question 3
You can find an object's ancestors, and also the method lookup path by calling
the `#ancestors` method on a class.

Orange:
Orange
Taste
Object
Kernel
BasicObject

HotSauce:
HotSauce
Taste
Object
Kernel
BasicObject

# Question 4
attr_accessor :type

# Question 5
excited_dog #=> local variable (no symbol before name)
@excited_dog #=> instance variable (`@`)
@@excited_dog #=> class variable (`@@`)

# Question 6
`self.manufacturer` because the method name is prefixed by `self`.

# Question 7
`@@cats_count` is a class variable of the `Cat` class that keeps track of the number
of `Cat` objects that have been instantiated. This can be seen on line 7, where the 
`initialize` method, which is called every time a new object is created,
includes the code `@@cats_count += 1`, which increments the variable by 1.
`@@cats_count` can be returned by calling the `self.cats_count` method, 
which simply returns the value of the variable, in this case the number of `Cat` 
objects that have been instantiated. The method can be called with the code `Cat.cats_count`.

# Question 8
` < Game`

# Question 9
Anytime we called the method `play` on an object of the `Bingo` class, it would
run the method in the `Bingo` class and not the `Game` class. This is due to the
fact that `Bingo` comes before `Game` in the lookup path.

# Question 10
1. Allows us to write dryer code (less repetition).
2. Allows us to organize code in a heirarchical manner.
3. Allows us to make certain parts of code available to only select viewers.
=end
