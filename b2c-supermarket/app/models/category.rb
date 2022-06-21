class Category < ApplicationRecord

  has_ancestry # 级联关系

  has_many :products, dependent: :destroy
end