
class Project < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :category

  belongs_to :client, class_name: "User"

  belongs_to :creater, class_name: "User"

  belongs_to :organization

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
