class ChangeDateToDatetimeOnSearch < ActiveRecord::Migration[5.0]
  def change
    change_column :searches, :last_run, :datetime
  end
end
