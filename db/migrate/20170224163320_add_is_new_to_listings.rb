class AddIsNewToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :isnew, :boolean
  end
end
