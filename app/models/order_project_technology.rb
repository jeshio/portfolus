# == Schema Information
#
# Table name: order_project_technologies
#
#  id               :integer          not null, primary key
#  order_project_id :integer
#  technology_id    :integer
#


class OrderProjectTechnology < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :technology

  belongs_to :order_project

  # followed by association macros


  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
