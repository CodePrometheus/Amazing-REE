class Product < ApplicationRecord

  validates :category_id, presence: {
    message: "category can't be blank"
  }
  validates :title, presence: {
    message: "title can't be blank"
  }
  validates :status, inclusion: {
    in: %w[on off],
    message: "商品状态必须为on | off"
  }
  validates :amount, numericality: {
    only_integer: true,
    message: "amount must be integer"
  }, if: proc { |product| !product.amount.blank? }

  validates :amount, presence: {
    message: "amount can't be blank"
  }
  validates :msrp, presence: {
    message: "msrp can't be blank"
  }
  validates :msrp, numericality: {
    message: "msrp must be number"
  }, if: proc { |product| !product.msrp.blank? }

  validates :price, numericality: {
    message: "price must be number"
  }, if: proc { |product| !product.price.blank? }
  validates :price, presence: {
    message: "price can't be blank"
  }
  validates :description, presence: {
    message: "description can't be blank"
  }

  belongs_to :category
  has_many :product_images, -> {
    order(weight: 'desc')
  }, dependent: :destroy # 级联删除

  before_create :set_default_attrs

  # 过滤上架
  scope :on_shelf, -> {
    where(status: Status::On)
  }

  has_one :main_product_image, -> {
    order(weight: 'desc')
  }, class_name: :ProductImage

  module Status
    On = 'on'
    Off = 'off'
  end

  private

  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end
end
