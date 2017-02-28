class CreateZones < ActiveRecord::Migration[5.0]
  def change
    create_table :zones do |t|
      t.string :name
      t.string :pp_url_part

      t.timestamps
    end
  end
end
