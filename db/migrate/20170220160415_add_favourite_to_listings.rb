class AddFavouriteToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :favourite, :boolean , default: false
  end
end
