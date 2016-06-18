# == Schema Information
#
# Table name: order_project_tags
#
#  id               :integer          not null, primary key
#  order_project_id :integer
#  tag_id           :integer
#


class OrderProjectTag < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :tag

  belongs_to :order_project

  # followed by association macros


  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks

   # finally, scopes
end
