class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :client_name
      t.string :email
      t.string :skype
      t.string :project

      t.timestamps
    end
  end

  def down
    drop_table :notes
  end
end
