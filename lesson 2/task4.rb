alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
answer = {}

alphabet.each_with_index do |letter, index|
  if vowels.include?(letter)
    answer[letter] = index + 1
  end  
end

puts answer
