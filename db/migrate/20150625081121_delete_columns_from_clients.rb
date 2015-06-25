class DeleteColumnsFromClients < ActiveRecord::Migration
  def change
  	remove_column :clients, :email
  	remove_column :clients, :skype
  	remove_column :clients, :project
  end
end
