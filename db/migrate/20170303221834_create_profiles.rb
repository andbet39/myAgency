class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :avatarimg_url
      t.string :agenzia

      t.timestamps
    end
  end
end
