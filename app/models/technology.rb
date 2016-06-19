# == Schema Information
#
# Table name: technologies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class Technology < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  has_many :project_technologies, :dependent => :destroy

  has_many :projects, through: :project_technologies

  has_many :order_project_technologies, :dependent => :destroy

  has_many :order_projects, through: :order_project_technologies

  validates :name, length: { minimum: 2 }

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
