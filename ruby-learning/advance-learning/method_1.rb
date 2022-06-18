# 默认参数
def foo(a, b)
  a + b
end

def foo(a, b, c = 1)
  a + b + c
end

p foo(1, 2) # 4
puts foo(1, 2, 4) # 7

# 可选参数 * 调用方法的时候可以传入任何数量和类型的参数，包括none
def foo(a, *b, c)
  p a
  p b
  p c
end

puts foo(1, [2, 3], 4) # 1, [2, 3], 4

# hash 参数
def bar(h)
  h.each do |k, v|
    p k, v
  end
end

puts bar(a: 3, b: 4) # {:a=>3, :b=>4}