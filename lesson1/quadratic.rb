puts "Введите коэффициент a"
a = Float(gets.chomp)
puts "Введите коэффициент b"
b = Float(gets.chomp)
puts "Введите коэффициент c"
c = Float(gets.chomp)
discriminant = b**2 - 4 * a * c
if discriminant > 0
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Дискриминант равен #{discriminant}, корни: x1 равен #{x1}, x2 равен #{x2}"
elsif discriminant == 0
  x = -b / (2 * a)	
  puts "Дискриминант равен #{discriminant}, корень x равен #{x}"
else  
  puts "Дискриминант равен #{discriminant}. Корней нет."
end