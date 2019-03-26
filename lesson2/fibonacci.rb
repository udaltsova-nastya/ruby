# Первый вариант решения
# Метод получения числа Фибоначчи по его порядковому номеру
#def fibonacci(n)
#  if n < 3
#    1
#  else
#    fibonacci(n - 1) + fibonacci(n - 2)
#  end
#end
#fibonacci_numbers = []
# порядковый номер числа Фибоначчи
#fibonacci_index = 1

# Бесконечный цикл
#while true do
  # Текущее число Фибоначчи
#  current_fibonacci_number = fibonacci(fibonacci_index)
  # Прерываем цикл while, если текущее число Фиббоачи больше 100
#  break if current_fibonacci_number >= 100
#  puts "#{fibonacci_index} -- #{current_fibonacci_number}"
#  fibonacci_numbers << current_fibonacci_number
#  fibonacci_index += 1
#end
#Второй вариант решения
fibonacci = [1, 1]
current_fibonacci_number = 2
 while current_fibonacci_number < 100 do
 	# так же есть вариант fibonacci.push(current_fibonacci_number)
 	 fibonacci << current_fibonacci_number
 	 current_fibonacci_number = fibonacci.last + fibonacci[-2]
 end
 puts fibonacci