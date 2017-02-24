class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t|
      t.string :inttype
      t.integer :vote 
      t.integer :interest
      t.text :note
      t.references :listing, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
