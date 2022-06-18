a = Array.new(10) { rand(100) }
puts a.inspect

a = Array.new(3, 'asdf')
puts a[0]
puts a[0][0] = 'b'
puts a[0]
puts a.inspect # ["bsdf", "bsdf", "bsdf"] 三个指向的都是同一个地址  | 区别于 Array.new(3) { 'asdf' }

a = Array.new(3) { 'abcd' }
a.each_with_index { |e, i| p [e[1], i] }

a = { name: 'Starry' }
b = a
puts b.object_id, a.object_id
puts a
a[:name] = 'foo'
puts a