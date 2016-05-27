class AddCreatedProjectsCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :created_projects_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |p|
      User.update_counters p.id, :created_projects_count => p.created_projects.length
    end
  end

  def self.down
    remove_column :users, :created_projects_count
  end
end
