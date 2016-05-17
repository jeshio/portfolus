
class User < ApplicationRecord

  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros



  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks
  protected

  def confirmation_required?
    false
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

   # finally, scopes
end
