class AddZoneToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches , :zone_id, :integer

  end
end
