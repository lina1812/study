puts "Введите 3 коэффициента через пробел"
array = gets.chomp.split
a = array[0].to_f
b = array[1].to_f
c = array[2].to_f

d = b**2 - 4 * a * c

if d > 0
  x1 = (-b + Math.sqrt(d))/(2*a)
  x2 = (-b - Math.sqrt(d))/(2*a)
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
  
elsif d == 0
  x = -b / (2*a)
  puts "D = #{d}, x = #{x}"
  
elsif
  puts "D = #{d} , корней нет"

end