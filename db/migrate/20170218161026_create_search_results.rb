class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.references :search, foreign_key: true
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
