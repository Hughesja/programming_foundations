# Question 1: What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers # 1, 2, 2, 3 since uniq is not mutating the variable

# Question 2: Describe the difference between ! and ? in Ruby. And explain what
# would happen in the following scenarios: 

# ! Is used in the NOT EQUAL operator and is used to mutate methods
# ? Is used to typically check something (ex. method.integer?)

# 1. What is != and where should you use it? 
  #if 1 != 2 # != means not equal
    #puts 'hello'
  #end  
# 2. Put ! before something, like !user_name 
  #!true # this will return false
# 3. Put ! after something, like words.uniq! 
  #arr = [1, 2, 2, 3]
  #arr.uniq!
# 4. Put ? before something 
  #1 ? 2 : 3 # used for if..else
# 5. Put ? after something 
  #num.include?(5) # checks to see if 5 is in num
#6. Put !! before something, like !!user_name
  #!!true # returns true


# Question 3: Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')

# Question 4: The Ruby Array class has several methods for removing items from 
# the array. Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

# What does the follow method calls do (assume we reset numbers to the original 
# array between method calls)?

numbers.delete_at(1) # numbers = [1, 3, 4, 5]
numbers.delete(1) # numbers = [2, 3, 4, 5]

# Question 5: Programmatically determine if 42 lies between 10 and 100.

(10..100).include?(42)

# Question 6: Starting with the string:

famous_words = "seven years ago..."

# show two different ways to put the expected "Four score and " in front of it.

famous_words.insert(0, "Four score and ") # I wanted to list many ways 
"Four score and " + famous_words          # since I got stuck on this one
famous_words.prepend("Four score and ")
"Four score and " << famous_words

# Question 7: Fun with gsub:

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

# This gives us a string that looks like a "recursive" method call:

"add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

# If we take advantage of Ruby's Kernel#eval method to have it execute this
# string as if it were a "recursive" method call

eval(how_deep)

# What will be the result?

42 # I looked at the solution and didn't understand this. Ruby Docs didn't help.

# Question 8: If we build an array like this:

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

# We will end up with this "nested" array:

["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

# Make this into an un-nested array.

p flintstones.flatten

# Question 9: Given the hash below

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

# Turn this into an array containing only two elements: Barney's name and Barney's number

flintstones.assoc('Barney')

# Question 10: Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are 
# the positions in the array.

flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end