class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :link
      t.string :tel
      t.string :tel2
      t.string :email
      t.text :description
      t.date :insert_date
      t.integer :mt
      t.string :zona
      t.string :id_annuncio
      t.string :origin
      t.string :price

      t.timestamps
    end
  end
end
