# == Schema Information
#
# Table name: project_executers
#
#  id                 :integer          not null, primary key
#  project_id         :integer
#  role               :string
#  start_date         :datetime
#  finish_date        :datetime
#  executer_confirmed :boolean          default("false")
#  creater_confirmed  :boolean          default("false")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  executer_id        :integer
#



class ProjectExecuter < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :project

  belongs_to :executer, class_name: "User", counter_cache: :executed_projects_count

  has_many :project_confirms, :dependent => :destroy

  validates :project_id, uniqueness: { scope: [:executer_id] }

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
