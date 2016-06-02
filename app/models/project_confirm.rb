# == Schema Information
#
# Table name: project_confirms
#
#  id                  :integer          not null, primary key
#  project_executer_id :integer
#  comment             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  confirmer_id        :integer
#


class ProjectConfirm < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :confirmer, class_name: "User"

  belongs_to :project_executer

  # followed by association macros

  # and validation macros
  validates :comment, length: { minimum: 2 }

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
