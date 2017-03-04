class AddIsProToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_pro, :boolean , default: false
    add_column :users, :stripe_token , :string
  end
end
