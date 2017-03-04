class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :description
      t.string :source
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
