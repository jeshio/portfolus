class AddExecutedProjectsCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :executed_projects_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |p|
      User.update_counters p.id, :executed_projects_count => p.executed_projects.length
    end

    def self.down
      remove_column :users, :executed_projects_count
    end
  end
end
