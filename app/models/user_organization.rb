# == Schema Information
#
# Table name: user_organizations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  organization_id :integer
#  start_date      :datetime
#  finish_date     :datetime
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


class UserOrganization < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :user

  belongs_to :organization

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
