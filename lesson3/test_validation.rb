require_relative "validation"

class Dog
  include Validation

  validate :name, :presence
  validate :name, :type, String

  attr_accessor :name
end

class Cat
  include Validation

  validate :name, :presence
  validate :name, :format, /^[A-Z].{3,8}$/

  attr_accessor :name
end

dog = Dog.new
puts dog.valid?
# => false

dog.name = :bobik
puts dog.valid?
# => false

dog.name = "Bobik"
puts dog.valid?
# => true

cat = Cat.new
cat.valid?
puts cat.valid?
# => false

cat.name = "Zu"
puts cat.valid?
# => false

cat.name = "Murka"
puts cat.valid?
# => true
