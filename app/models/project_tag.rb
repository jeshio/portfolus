# == Schema Information
#
# Table name: project_tags
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ProjectTag < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :tag

  belongs_to :project

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
