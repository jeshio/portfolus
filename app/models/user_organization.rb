
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
