class AddBudget < ActiveRecord::Migration
  def change
  	add_column :clients, :budget, :integer
  end
end
