puts "Введите день, месяц, год через пробел"
date = gets.chomp.split.map{ |i| i.to_i }

month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
month[1] = 29 if ((date[2] % 4 == 0 && date[2] % 100 != 0) || date[2] % 400 == 0)

date_number = 0
for i in 0..(date[1] - 2)
  date_number += month[i]
end
date_number += date[0]

puts "#{date[0]}.#{date[1]}.#{date[2]} это #{date_number} день в году" 
