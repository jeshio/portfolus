
class City < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros

  belongs_to :country


  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks


   # finally, scopes
end
