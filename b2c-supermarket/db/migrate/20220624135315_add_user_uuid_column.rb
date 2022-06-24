class AddUserUuidColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uuid, :string
    add_index :users, [:uuid], unique: true

    User.find_each do |user|
      user.uuid = RandomCode.generate_user_token
      user.save
    end
  end
end
