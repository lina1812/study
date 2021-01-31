fib = [0]
fib_next = 1

while fib_next <= 100
  fib << fib_next
  fib_next += fib[-2]
end

puts fib.inspect
