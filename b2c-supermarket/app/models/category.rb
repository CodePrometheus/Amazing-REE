class Category < ApplicationRecord

  validates :title, presence: {
    message: "name can't be blank"
  }
  validates :title, uniqueness: {
    message: "name has been used"
  }

  has_ancestry orphan_strategy: :destroy # 级联关系 一级删除后二级自动删除

  has_many :products, dependent: :destroy # 对应下面的商品

  before_validation :correct_ancestry

  def self.grouped_data
    # stream
    self.roots.order("weight desc").inject([]) do |res, parent|
      row = []
      row << parent
      row << parent.children.order("weight desc")
      res << row
    end
  end

  private

  def correct_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end
end