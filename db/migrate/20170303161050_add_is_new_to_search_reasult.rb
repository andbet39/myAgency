class AddIsNewToSearchReasult < ActiveRecord::Migration[5.0]
  def change
    add_column :search_results, :is_new, :boolean
  end
end
