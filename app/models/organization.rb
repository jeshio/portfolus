# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  url         :text
#  reg_hash    :string
#  admin_email :string
#  domen       :string
#  views       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creater_id  :integer
#


class Organization < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :creater, class_name: "User"

  has_many :user_organizations, :dependent => :destroy

  has_many :users, through: :user_organization

  # followed by association macros

  # and validation macros
  validates :url, uniqueness: true
  validates :domen, uniqueness: true, presence: true
  validate :user_has_email

  # проверка, что у пользователя добавлен e-mail в домене добавляемой организации
  def user_has_email
    if creater.emails.where("email LIKE ?", "%@#{domen}").first.nil?
      errors.add(:domen, "вы должны добавить e-mail в домене организации")
    end
  end

  # next we have callbacks
  before_create do
    self.admin_email = creater.emails.where("email LIKE ?", "%@#{domen}").first.email
  end


  # other macros (like devise's) should be placed after the callbacks
  # все организации, в которых юзер админ
  def self.where_admin(emails)
    return [] if emails.blank?
    Organization.where("admin_email in (?)", emails)
  end

  # организации, в которые пользователь может вступить, но ещё не вступил
  # emails - его почты
  # exists - организации, в которые вступил
  def self.available(emails, exists)
    return [] if emails.blank?
    domains = emails.map { |e| e.split("@").last  }.uniq

    if exists.blank?
      Organization.where("domen in (?) AND admin_email NOT IN (?)", domains, emails)
    else
      Organization.where("domen in (?) AND admin_email NOT IN (?) AND id NOT IN (?)", domains, emails, exists)
    end
  end

   # finally, scopes
end
