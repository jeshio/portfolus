
class User < ApplicationRecord

  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  has_many :user_organization
  has_many :organization, through: :user_organization
  has_many :created_organization, :foreign_key => "creater", :class_name => "Organization"
  has_many :confirms, :foreign_key => "confirmer", :class_name => "ProjectConfirm"
  has_many :project_executer, :foreign_key => "executer", :class_name => "ProjectExecuter"
  has_many :created_projects, :foreign_key => "creater", :class_name => "Project"
  has_many :ordered_projects, :foreign_key => "client", :class_name => "Project"

  belongs_to :city, optional: true

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
