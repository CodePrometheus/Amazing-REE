class Order < ApplicationRecord

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true
  validates :order_no, presence: true

  belongs_to :user
  belongs_to :product
  belongs_to :address

  before_create :generate_order_no

  def self.create_order!(user, address, *shopping_carts)
    shopping_carts.flatten!
    address_attrs = address.attributes.except!('id', 'created_at', 'updated_at') # 去除
    # 事务
    transaction do
      # 修改地址类型
      order_address = user.addresses.create!(address_attrs.merge(
        "address_type" => Address::AddressType::Order
      ))
      shopping_carts.each do |shopping_cart|
        user.orders.create!(
          product: shopping_cart.product,
          address: order_address,
          amount: shopping_cart.amount,
          total_money: shopping_cart.amount * shopping_cart.product.price
        )
      end

      #  清除购物车
      shopping_carts.map(&:destroy!)
    end
  end

  private

  def generate_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
