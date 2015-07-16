class CreateProjectsTable < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :project_name
      t.integer :client_id
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
