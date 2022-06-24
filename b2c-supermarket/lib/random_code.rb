module RandomCode
  class << self
    def generate_password(len = 8)
      seed = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a + %w[! @ # $ % . *] * 4
      token = ""
      len.times { |t| token << seed.sample.to_s }
      token
    end

    def generate_cellphone_token(len = 6)
      a = lambda { (0..9).to_a.sample }
      token = ""
      len.times { |t| token << a.call.to_s }
      token
    end

    def generate_user_token(len = 8)
      a = lambda { rand(36).to_s(36) }
      token = ""
      len.times { |t| token << a.call.to_s }
      token
    end

    def generate_product_uuid
      Date.today.to_s.split('-')[1..-1].join() << generate_user_token(6).upcase
    end

    def generate_order_uuid
      Date.today.to_s.split('-').join()[2..-1] << generate_user_token(5).upcase
    end
  end
end