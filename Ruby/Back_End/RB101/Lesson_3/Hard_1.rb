=begin
# 1.
It will return 'nil'.

# 2.
{:a => "hi there"}

# 3.
A)
one is: one
two is: two
three is: three
B)
one is: one
two is: two
three is: three
C)
one is: two
two is: three
three is: one

# 4.
def is_an_ip_number?(string)
  string.to_i <= 255
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  
  return false if dot_separated_words.size != 4
  
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  
  true
end
=end
