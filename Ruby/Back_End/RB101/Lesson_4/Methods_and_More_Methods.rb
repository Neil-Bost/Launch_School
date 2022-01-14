=begin
# 1.
The return value is [1, 2, 3] because the Array#select method returns a copy of
the array on which it is called with only the elements for which the block
returns a truthy value. Because the string 'hi' is truthy, every element of the
original array is returned.

# 2.
The Array#count method treats the block's return value by evaluating its
truthiness. We can find this out by reading the documentation for the method.

# 3.
The return value is [1, 2, 3], because reject returns a copy of the array on
which it is called for all of the elements for which the block returns false.
Becuase 'puts num' returns nil, which is a falsey value, every element is kept.

# 4.
The return value is {'a'=>'ant', 'b'=>'bear', 'c'=>'cat'} because the
Enumerable#each_with_object method returns the given object, in this case 'hash'.

# 5.
#shift removes the first key/value pair and returns it as an array. We can
find out by reading the documentation.

# 6.
The return value is 11 because Array#pop returns the last element of the array on
which it is called, and String#size returns an integer representing the number
of characters in the string.

# 7.
The block's return value is a boolean. It is determined by the return value of 
the last expression in the block, in this case #odd?. The return value of
any? is 'true' because Array#any? returns true if the block returns true on any
of the elements in the array on which it is called.

# 8.
Array#take works by returning the first n element(s) of the array (where n is the
argument given). It is not destructive. We can find out by reading the
documentaion.

# 9.


#10.
The return value is [1, nil, nil] because #map runs the block on each element in
the array on which it is called. The block only returns the element if the
condition (element > 1) is false. 1 is the only element for which this is false.
The elements for which this is true get a return value of 'nil' becuase puts num
returns nil.
=end
