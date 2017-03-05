class AddPlanEndDateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pro_end_date , :datetime
    add_column :users, :stripe_customer_id , :string

  end
end
