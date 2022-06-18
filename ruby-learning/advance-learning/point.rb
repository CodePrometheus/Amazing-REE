class Point
  attr_accessor :x # getter setter
  attr_reader :y # getter

  @@origin = 0 # 全局变量
  ORIGIN = 2 # Point::ORIGIN

  def initialize(x = 0, y = 0)
    # @ instance variable
    # @@ class variable
    # &x global variable
    # x local variable
    @x, @y = x, y
  end

  def first_quadrant?
    x > 0 && y > 0 # self.x
  end

  private :first_quadrant?

  def +(p2)
    Point.new(x + p2.x, y + p2.y)
  end

  def second_quadrant? # class method
    x > 0 && y > 0 # self.x
  end

  protected :second_quadrant?
end