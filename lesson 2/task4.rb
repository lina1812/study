alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
answer = {}

alphabet.each.with_index(1) do |letter, index|
  if vowels.include?(letter)
    answer[letter] = index
  end  
end

puts answer
