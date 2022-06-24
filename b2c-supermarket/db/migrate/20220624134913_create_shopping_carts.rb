class CreateShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id # 允许用户未登录加入购物车
      t.string :user_uuid # 追踪用户
      t.integer :product_id
      t.integer :amount
      t.timestamps
    end

    add_index :shopping_carts, [:user_id]
    add_index :shopping_carts, [:user_uuid]
  end
end
