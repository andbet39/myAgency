class AddZoneIdtoListings < ActiveRecord::Migration[5.0]
  def change
    remove_column  :listings, :zone
    add_column :listings , :zone_id, :integer

  end
end
