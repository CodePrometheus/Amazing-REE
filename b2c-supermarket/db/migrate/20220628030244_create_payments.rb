class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :payment_no, :transaction_no
      t.string :status, default: 'initial'
      t.decimal :total_money, precision: 10, scale: 2
      t.timestamps
    end
  end
end
