puts "Введите 3 стороны треульника через пробел"
array = gets.chomp.split.sort
a = array[0].to_f
b = array[1].to_f
c = array[2].to_f

if a == b && a==c && b == c 
  puts "Треугольник равносторонний"
end
if a == b || a==c || b == c
  puts "Треугольник равнобедренный"
end
if c**2 == a**2 + b**2
  puts "Треугольник прямоугольный"
end