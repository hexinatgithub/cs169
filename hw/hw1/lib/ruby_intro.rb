# When done, submit this entire file to the autograder.

# Part 1

# Method sum(array) that takes an array of integers as an argument 
# and returns the sum of its elements. 
# For an empty array it should return zero.
def sum(arr)
  arr.length > 0 ? arr.inject(:+) : 0
end

# Method max_2_sum(array) which takes an array of integers as an argument 
# and returns the sum of its two largest elements.
def max_2_sum(arr)
  sum arr.sort {|a, b| b <=> a }.slice 0, 2
end

# Method sum_to_n?(array, n) that takes an array of integers and an additional integer, n, as arguments 
# and returns true if any two elements in the array of integers sum to n. 
#sum_to_n?([], n) should return false for any value of n, by definition.
def sum_to_n?(arr, n)
  arr.combination(2).to_a.select { |a| sum(a) == n }.size > 0
end

# Part 2
# Method hello(name) that takes a string representing a name 
# and returns the string "Hello, " concatenated with the name.
def hello(name)
  "Hello, #{name}"
end

# Method starts_with_consonant?(s) that takes a string 
# and returns true if it starts with a consonant and false otherwise. 
# (For our purposes, a consonant is any letter other than A, E, I, O, U.) 
def starts_with_consonant?(s)
  (s =~ /^[a-z]+/i) && !s.upcase.start_with?("A", "E", "I", "O", "U")
end

# Method binary_multiple_of_4?(s) that takes a string and 
# returns true if the string represents a binary number that is a multiple of 4.
def binary_multiple_of_4?(s)
  s =~ /(^[0-1]*(100)$|^0$)/
end

# Part 3

class BookInStock
  attr_accessor :isbn
  attr_accessor :price
  
  def initialize(isbn, price)
    if isbn.size == 0 || price <= 0
      raise ArgumentError
    end
    @isbn = isbn
    @price = price
  end
  
  def price_as_string
    format("$%2.2f", self.price)
  end
end
