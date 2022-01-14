=begin
# 1.
flintstones_hash = {}
flintstones.each do |name|
  flintstones_hash[name] = flintstones.index(name)
end

p flintstones_hash

# 2.
age_values = []
ages.each do |key, value|
  age_values << value
end

p age_values.sum

# 3.
ages.delete_if do |key, value|
  value > 100
end

p ages

# 4.
p ages.values.min

# 5.
### First answer:
flintstones.each do |name|
  if name[0..1] == 'Be'
    puts flintstones.index(name)
    break
  end
end

### Second attempt:


# 6.
flintstones.each do |name|
  name.slice!(3..-1)
end

# 7.
letter_frequency = {}
statement.each_char do |letter|
  letter_frequency[letter] = statement.count(letter)
end

# 8.
### First code

### Second code
1
2

# 9.
words.split.map! { |word| word.capitalize }.join(" ")

# 10.
munsters.each do |key, value|
  if (0..17).include?(munsters[key]["age"])
    munsters[key]["age_group"] = "kid"
  elsif (18..64).include?(munsters[key]["age"])
    munsters[key]["age_group"] = "adult"
  else
    munsters[key]["age_group"] = "senior"
  end
end
=end
