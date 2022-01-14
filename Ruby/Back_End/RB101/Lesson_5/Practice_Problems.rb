=begin
# Practice Problem 1
arr.sort do |a,b|
  b.to_i <=> a.to_i
end


# Practice Problem 2
books.sort_by do |hash|
  hash[:published].to_i
end


# Practice Problem 3
arr1[2][1][3]
arr2[1][:third][0]
arr3[2][:third][0][0]
hsh1['b'][1]
hsh2[:third].key(0)


# Practice Problem 4
arr1[1][1] = 4
arr2[2] = 4
hsh1[:first][2][0] = 4
hsh2[['a']][:a][2] = 4


# Practice Problem 5
age = 0
munsters.values.each do |hash|
  age += hash["age"] if hash["gender"] == "male"
end


# Practice Problem 6
munsters.each do |name, info|
  puts "#{name} is a #{info["age"]}-year-old #{info["gender"]}."
end


# Practice Problem 7
a = 2
b = [3, 8]


# Practice Problem 8
hsh.each do |_, strings|
  strings.each do |words|
    words.each_char do |letters|
      puts letters if %w(a e i o u).include?letters
    end
  end
end


# Practice Problem 9
arr.map do |sub_arr|
  sub_arr.sort do |a, b|
    b <=> a
  end
end


# Practice Problem 10
arr.map do |hash|
  hash.each do |k, v|
    hash[k] += 1
  end
end


# Practice Problem 11
arr.map do |sub_arr|
  sub_arr.select do |num|
    num % 3 == 0
  end
end


# Practice Problem 12
hash = {}
arr.each do |sub_arr|
  hash[sub_arr[0]] = sub_arr[1]
end


# Practice Problem 13
arr.sort_by do |sub_arr|
  sub_arr.select do |num| 
    num.odd?
  end
end


# Practice Problem 14
hsh.values.map do |hash|
  if hash[:type] == 'fruit'
    hash[:colors].map do |color| 
      color.capitalize
    end
  elsif hash[:type] == 'vegetable'
    hash[:size].upcase
  end
end


# Practice Problem 15


# Practice Problem 16
def hex_randomizer(num)
  hexadecimal_pieces = ("0".."9").to_a, ("a".."f").to_a
  hexadecimals = hexadecimal_pieces.flatten
  hexes = ""
  counter = 0
  while counter < num
    hexes << hexadecimals.sample
    counter += 1
    hexes << "-" if counter == num unless num == 12
  end
  
  hexes
end

def uuid
  hex = ""
  hex << hex_randomizer(8)
  hex << hex_randomizer(4)
  hex << hex_randomizer(4)
  hex << hex_randomizer(4)
  hex << hex_randomizer(12)
  hex
end


