class AddUserToCutomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :user_id, :integer
  end
end
