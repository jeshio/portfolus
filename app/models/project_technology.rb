# == Schema Information
#
# Table name: project_technologies
#
#  id            :integer          not null, primary key
#  technology_id :integer
#  project_id    :integer
#  power         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


class ProjectTechnology < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :technology

  belongs_to :project

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
