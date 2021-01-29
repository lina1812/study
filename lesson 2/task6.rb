shopping_basket = {}
input = []
puts "Введите название товара, цену за единицу и кол-во купленного товара через пробел"
puts "Каждый товар вводите с новой строки"
puts "Введите 'стоп' для выхода"

loop do
  input << gets.chomp
  break if input.include?("стоп")
end

total = 0

for i in 0..input.size - 2
  product = input[i].split
  price = product[1].to_f
  count = product[2].to_f
  shopping_basket[product[0]] = {
    price: price,
    count: count, 
    sum: price * count
  }
  total += shopping_basket[product[0]][:sum]
end

puts shopping_basket.inspect
puts "Общая сумма покупок #{total}"
