# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  start_date      :datetime
#  dev_finish_date :datetime
#  finish_date     :datetime
#  views           :decimal(, )
#  version         :string
#  category_id     :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  creater_id      :integer
#


class Project < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :category

  belongs_to :client, class_name: "User"

  belongs_to :creater, class_name: "User"

  belongs_to :organization

  has_many :project_tag, dependent: :destroy

  has_many :project_technology, dependent: :destroy

  has_many :tag, through: :project_tag

  has_many :project, through: :project_technology

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
