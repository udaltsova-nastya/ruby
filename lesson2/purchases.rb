purchases = {}
total_cost = 0

loop do
  puts "Введите название товара"
  product = gets.chomp
  break if product == "стоп"
  puts "Введите цену за единицу товара"
  price = Float(gets.chomp)
  puts "Введите количество товара"
  count =  Float(gets.chomp)

  purchases[product] = { price: price, count: count }
end

purchases.each do |product, props|
  price = props[:price]
  count = props[:count]
  cost = price * count
  puts "Товар: #{product}, цена: #{price}, количество: #{count}, стоимость: #{cost}"
  total_cost += cost
end 

puts "Итоговая сумма товаров в корзине: #{total_cost}"
