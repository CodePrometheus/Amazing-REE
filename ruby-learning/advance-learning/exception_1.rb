def factorial(n)
  raise TypeError unless n.is_a? Integer
  raise ArgumentError if n < 1
  return 1 if n == 1
  n * factorial(n - 1)
end

begin
  x = factorial(0)
rescue ArgumentError => e
  p "Try again with a value >= 1: ", e.backtrace
rescue TypeError => e
  p "Try again with an Integer: ", e.backtrace
else
  p x
ensure
  p "ensure block"
end

arr = [1, 2, 'asdf', 3, 'hello', 'world', 'hjkl', 0.3]

def sum_pair(arr)
  sum = 0
  arr.each_slice(2) do |pair|
    begin
      p pair[0] + pair[1]
    rescue TypeError => e
      p "Invalid summation of #{pair[0].class} + #{pair[1].class} ", e.backtrace
    ensure
      sum += 1
    end
  end
  p "Total pairs: #{sum}"
end

p sum_pair(arr)