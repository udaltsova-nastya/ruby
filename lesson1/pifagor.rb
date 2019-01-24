puts "Введите сторону 1"
side_one = Float(gets.chomp)
puts "Введите сторону 2"
side_two = Float(gets.chomp)
puts "Введите сторону 3"
side_three = Float(gets.chomp)
# необходимо определить большую сторону (гипотенузу). 
# создаем массив из полученных значений и применяем метод .sort (упорядочиваем по возрастанию)
sorted_sides = [side_one, side_two, side_three].sort
hypotenuse = sorted_sides[2]
side_a = sorted_sides[1]
side_b = sorted_sides[0]
# проверяем теорему Пифагора 
if hypotenuse**2 == side_a**2 + side_b**2
  puts "Треугольник прямоугольный"
  # проверяем, является ли прямоугольный треугольник равнобедренным
  if side_a == side_b
  	puts "Треугольник равнобедренный"
  else
    puts "Треугольник не равнобедренный"
  end	
else
  puts "Треугольник не является прямоугольным"
end