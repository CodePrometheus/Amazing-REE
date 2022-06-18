class Greeter

  attr_accessor :names

  def initialize(names = "zzStar")
    @names = names
  end

  def say_hi
    # 如果 @names 对象可以回应 each 函数，那它就是可以被迭代的， 于是我们对它做迭代，向每个人问好。最后如果 @names 是其他的类， 就把它转化为字符串，用默认的方式问好。
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      #each 是一个可以接受代码块的函数。它在迭代每一个元素时都会调用一次之前所接受到的代码块。 代码块像是一个不需要命名的函数，和 lambda 类似。 在| |之间的就是传输给代码块的参数
      @names.each do |name|
        #每一次循环中，name 首先被赋值为 list 里面一个对应元素的值， 然后作为参数传递到 puts "Hello #{name}!" 这句命令里
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end

  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # Join the list elements with commas
      # 查看 @names 是否支持 join 函数。如果是的话就调用，否则就简单的将变量转化为字符串
      puts "Goodbye #{@names.join(", ")}.  Come back soon!"
    else
      puts "Goodbye #{@names}.  Come back soon!"
    end
  end
end

# __FILE__ 是一个魔法值，它存有现在运行的脚本文件的名字。$0 是启动脚本的名字。 代码里的比较结构的意思是 “如果这是启动脚本的话…” 这允许代码作为库调用的时候不运行启动代码， 而在作为执行脚本的时候调用启动代码
if __FILE__ == $0
  mg = Greeter.new
  mg.say_hi
  mg.say_bye

  # Change name to be "Zeke"
  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  # Change the name to an array of names
  mg.names = ["Albert", "Brenda", "Charles", "Dave", "Engelbert"]
  mg.say_hi
  mg.say_bye

  # Change to nil
  mg.names = nil
  mg.say_hi
  mg.say_bye
end
