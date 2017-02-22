class AddNameToInteraction < ActiveRecord::Migration[5.0]
  def change
    add_column :interactions, :name, :string 
  end
end
