class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.belongs_to :product
      t.integer :weight, default: 0
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
