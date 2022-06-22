class Category < ApplicationRecord

  validates :title, presence: {
    message: "name can't be blank"
  }
  validates :title, uniqueness: {
    message: "name has been used"
  }

  has_ancestry orphan_strategy: :destroy # 级联关系 一级删除后二级自动删除

  has_many :products, dependent: :destroy

  before_validation :correct_ancestry

  private

  def correct_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end
end