# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  url         :text
#  reg_hash    :string
#  admin_email :string
#  domen       :string
#  views       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creater_id  :integer
#


class Organization < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :creater, class_name: "User"

  has_many :user_organization, :dependent => :destroy

  has_many :user, through: :user_organization

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
