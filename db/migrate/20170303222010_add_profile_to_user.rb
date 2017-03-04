class AddProfileToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_id, :integer

  end
end
