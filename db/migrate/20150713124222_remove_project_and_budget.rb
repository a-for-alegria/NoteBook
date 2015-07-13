class RemoveProjectAndBudget < ActiveRecord::Migration
  def change
  	remove_column :clients, :project
  	remove_column :clients, :budget
  end
end
