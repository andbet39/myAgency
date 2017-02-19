class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :keyword
      t.string :zona
      t.date :last_run

      t.timestamps
    end
  end
end
