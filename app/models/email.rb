# == Schema Information
#
# Table name: emails
#
#  id           :integer          not null, primary key
#  email        :string
#  confirm_hash :string
#  confirmed    :boolean          default("false")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#


class Email < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros


  # and validation macros
  validates :email, uniqueness: true

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
