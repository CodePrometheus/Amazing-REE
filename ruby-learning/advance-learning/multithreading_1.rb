Thread.new {}

def foo
  10.times { puts "Call foo at #{Time.now}" }
  sleep(0.5)
end

def bar
  10.times { puts "Call bar at #{Time.now}" }
  sleep(0.5)
end

p '*' * 10 + 'start' + '*' * 10
t1 = Thread.new { foo() }
t2 = Thread.new { bar() }
t1.join # 顺序执行
t2.join
p '*' * 10 + 'end' + '*' * 10

c1 = c2 = 0
diff = 0
Thread.new do
  loop do
    c1 += 1
    c2 += 1
  end
end

Thread.new do
  loop do
    diff += (c1 - c2).abs
  end
end

sleep 2
p "c1: #{c1}, c2: #{c2}, diff: #{diff}"

p '*' * 10 + 'end' + '*' * 10

mu = Mutex.new
c1 = c2 = 0
diff = 0
Thread.new do
  loop do
    mu.synchronize do
      c1 += 1
      c2 += 1
    end
  end
end

Thread.new do
  loop do
    mu.synchronize do
      diff += (c1 - c2).abs
    end
  end
end

sleep 1
mu.lock
p "c1: #{c1}, c2: #{c2}, diff: #{diff}"