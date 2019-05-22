# frozen_string_literal: true

require_relative "accessors"

class Dog
  include Accessors

  attr_accessor_with_history :owner
end

class Cat
  include Accessors

  strong_attr_accessor :plays_with, Cat
end

dog = Dog.new
dog.owner = "Михаил"
dog.owner = "Василий"
dog.owner = "Ольга"
p dog.owner_history
# => ["Михаил", "Василий", "Ольга"]

cat = Cat.new
another_cat = Cat.new
cat.plays_with = another_cat
puts "a cat plays only with another #{cat.plays_with.class}"
# => Cat

cat.plays_with = dog
puts cat.plays_with.class
# => ArgumentError
