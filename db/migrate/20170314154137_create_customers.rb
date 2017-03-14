class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    drop_table :customers

    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.string :phone1
      t.string :phone2
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
