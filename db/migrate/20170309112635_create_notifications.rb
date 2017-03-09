class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :body
      t.references :object, polymorphic: true
      t.boolean :notified
      t.boolean :seen
      t.boolean :emailed
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
