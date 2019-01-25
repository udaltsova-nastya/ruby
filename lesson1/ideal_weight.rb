print "Как вас зовут?" 
first_name = gets.chomp # .chomp данный метод убирает пустые значения, пробелы, если после ввода имени пользователь нажимает enter

first_name.capitalize! # .capitalize! означает, что имя пользователя всегда (!) будет отображаться с заглавной буквы

print "Какой у вас рост?"
height = Float(gets.chomp) # gets возвращает строку! Inrenger - целое число, Float-с плавающей точкой
ideal_weight = height - 110
print "#{first_name}, "

if ideal_weight > 0
  puts "Ваш идеальный вес #{ideal_weight} кг"
else
  puts "Ваш вес уже оптимальный"
end

