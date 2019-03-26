month_days = [
  31,
  28, 
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
]
february_index = 1

puts "Введите день"
day = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
month_days[february_index] = 29 if leap_year

day_of_year = month_days.first(month - 1).sum + day
puts day_of_year
