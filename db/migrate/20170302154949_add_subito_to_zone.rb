class AddSubitoToZone < ActiveRecord::Migration[5.0]
  def change
    add_column :zones, :subitourl, :string
  end
end
