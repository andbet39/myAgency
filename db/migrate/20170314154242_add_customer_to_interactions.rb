class AddCustomerToInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :interactions, :customer_id, :integer

  end
end
