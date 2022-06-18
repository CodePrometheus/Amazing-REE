def foo
  a = 2
  yield a
end

foo { |a| puts a }

def foo(&block)
  a = 2
  block.call(a)
end

foo { |a| puts a }

l = lambda { |x, y| p x, y }
# l.call(1, 2, 3) # 加 lambda 报错

def each_starts_with(arr, str)
  arr.each do |e|
    yield e if e.start_with?(str)
  end
end

each_starts_with(%w[foo bar baz], 'b') { |e| puts e }