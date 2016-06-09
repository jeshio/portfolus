# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default("0"), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string
#  last_sign_in_ip         :string
#  confirmation_token      :string
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  username                :string
#  family                  :string
#  name                    :string
#  middlename              :string
#  city_id                 :integer
#  views                   :integer
#  created_projects_count  :integer          default("0")
#  executed_projects_count :integer          default("0")
#



class User < ApplicationRecord

  # keep the default scope first (if any)
  scope :min_projects, -> min { where('"users"."executed_projects_count" >= ?', min) }
  scope :city_id, -> city_id { where(city_id: city_id) }

  # constants come up next

  # afterwards we put attr related macros
  has_many :user_organizations, :dependent => :destroy
  has_many :organization, through: :user_organization
  has_many :created_organization, :foreign_key => "creater_id", :class_name => "Organization", :dependent => :nullify
  has_many :confirms, :foreign_key => "confirmer_id", :class_name => "ProjectConfirm", :dependent => :destroy
  has_many :project_executers, -> { where creater_confirmed: true, executer_confirmed: true }, :foreign_key => "executer_id", :dependent => :destroy
  has_many :executed_projects, through: :project_executers, source: :project
  has_many :created_projects, foreign_key: "creater_id", class_name: "Project", :dependent => :nullify
  has_many :ordered_projects, :foreign_key => "client_id", :class_name => "Project", :dependent => :nullify
  has_many :emails, :dependent => :destroy

  belongs_to :city, optional: true

  # followed by association macros

  # and validation macros

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
