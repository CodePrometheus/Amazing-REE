class ExtendPoint < Point
  def initialize(x = 0, y = 0)
    super(x, y)
  end
end

class BaseFoo
  def foo
    private_methods
  end

  def private_methods
    p 'come to baseclass'
  end

  private :private_methods
end

class Foo < BaseFoo
  def bar
    ret = foo
    private_methods(ret)
  end

  def private_methods(ret = nil)
    p 'come to subclass'
  end

  private :private_methods
end

# foo = Foo.new
# foo.bar