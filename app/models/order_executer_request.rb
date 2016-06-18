# == Schema Information
#
# Table name: executer_requests
#
#  id               :integer          not null, primary key
#  order_project_id :integer
#  comment          :string
#  by_customer      :boolean
#  confirmed        :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  executer_id      :integer
#


class OrderExecuterRequest < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros

  belongs_to :order_project

  belongs_to :executer, class_name: "User", optional: true


  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
