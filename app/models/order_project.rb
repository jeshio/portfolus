# == Schema Information
#
# Table name: order_projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price_min   :integer
#  price_max   :integer
#  finished    :boolean
#  views       :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#  executer_id :integer
#


class OrderProject < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :category

  belongs_to :customer, class_name: "User"

  # followed by association macros


  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
