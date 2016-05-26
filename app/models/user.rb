# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  family                 :string
#  name                   :string
#  middlename             :string
#  city_id                :integer
#  views                  :integer
#


class User < ApplicationRecord

  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  has_many :user_organization, :dependent => :destroy
  has_many :organization, through: :user_organization
  has_many :created_organization, :foreign_key => "creater_id", :class_name => "Organization", :dependent => :nullify
  has_many :confirms, :foreign_key => "confirmer_id", :class_name => "ProjectConfirm", :dependent => :destroy
  has_many :executed_projects, :foreign_key => "executer_id", :class_name => "ProjectExecuter", :dependent => :destroy
  has_many :created_projects, :foreign_key => "creater_id", :class_name => "Project", :dependent => :nullify
  has_many :ordered_projects, :foreign_key => "client_id", :class_name => "Project", :dependent => :nullify

  belongs_to :city, optional: true

  # followed by association macros

  def all_projects
    self.created_projects.includes(project_technologies: :technology).includes(:tags).order('created_at desc') + self.executed_projects
    #@result.all.each { |e|  e.project_technologies.map { |t| e.technologies.map { |tt| e.project_technologies.  } }  }
  end

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
