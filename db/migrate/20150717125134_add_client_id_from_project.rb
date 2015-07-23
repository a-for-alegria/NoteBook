class AddClientIdFromProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :client_id
  end
end
