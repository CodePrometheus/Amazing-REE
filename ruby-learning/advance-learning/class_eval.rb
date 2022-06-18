class Adder
  def initialize(num)
    @num = num
  end

  def method_missing(method_name)
    regex = /^plus(\d+)$/
    if method_name =~ regex
      val = method_name[regex, 1].to_i
      eval "def #{method_name}; @num + #{val}; end; #{method_name}"
    else
      super
    end
  end
end

class AdderClassEval
  def initialize(num)
    @num = num
  end

  def method_missing(method_name)
    regex = /^plus(\d+)$/
    if method_name =~ regex
      val = method_name[regex, 1].to_i
      AdderClassEval.class_eval "def #{method_name}; @num + #{val}; end"
      eval "#{method_name}" # 自动生成方法
    else
      super
    end
  end
end

class AdderSelfEval
  def initialize(num)
    @num = num
  end

  def method_missing(method_name)
    regex = /^plus(\d+)$/
    if method_name =~ regex
      val = method_name[regex, 1].to_i
      self.class.send(:define_method, method_name) { @num + val }
      eval "#{method_name}"
    else
      super
    end
  end
end