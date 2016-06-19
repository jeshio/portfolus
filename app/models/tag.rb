# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  has_many :project_tags, :dependent => :destroy

  has_many :projects, through: :project_tags

  has_many :order_project_tags, :dependent => :destroy

  has_many :order_projects, through: :order_project_tags

  # followed by association macros

  # and validation macros
  validates :name, uniqueness: true

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
