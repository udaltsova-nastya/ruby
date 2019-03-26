# Первая версия
# alphabet = ("a".."z").to_a
# vowels = ["a", "e", "i", "o", "u"]
# vowels_index = {}
# alphabet.each_with_index(1) do |letter, index| 
#   vowels_index[letter] = index if vowels.include?(letter)
# end
#
# Вторая версия
alphabet = ("a".."z").to_a
vowels = "aeiou".split("")
vowels_index = {}
vowels.each { |vowel| vowels_index[vowel] = alphabet.index(vowel) + 1 }
puts vowels_index
