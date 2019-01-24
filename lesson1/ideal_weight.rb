print "Как вас зовут?" 
first_name = gets.chomp # .chomp данный метод убирает пустые значения, пробелы, если после ввода имени пользователь нажимает enter

first_name.capitalize! # .capitalize! означает, что имя пользователя всегда (!) будет отображаться с заглавной буквы

print "Какой у вас рост?"
height = gets.chomp # gets возвращает строку!
height = height.to_i # to_i преобразует строку в числовое значение
ideal_weight = height - 110
print "#{first_name}, "

if ideal_weight > 0
	puts "ваш идеальный вес #{ideal_weight} кг"
else 
	puts "Ваш вес уже оптимальный"
end
