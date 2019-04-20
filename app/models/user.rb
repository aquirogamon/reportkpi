# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  displayname            :string
#  title                  :string
#  permission_level       :integer          default(1)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PermissionsConcern
  
  validates :username, presence: true, uniqueness: true

  before_validation :get_ldap_email
  def get_ldap_email
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
  end

  # use ldap displayname as primary key
  before_validation :get_ldap_displayname
  def get_ldap_displayname
    self.displayname = Devise::LDAP::Adapter.get_ldap_param(self.username,"displayname").first
  end

  # use ldap title as primary key
  before_validation :get_ldap_title
  def get_ldap_title
    #self.title = Devise::LDAP::Adapter.get_ldap_param(self.username,"title").first
    if Devise::LDAP::Adapter.get_ldap_param(self.username,"title") != nil
      self.title = Devise::LDAP::Adapter.get_ldap_param(self.username,"title").first
    else
      self.title = "-"
    end
  end

  # hack for remember_token
  def authenticatable_salt
    Digest::SHA1.hexdigest(email)[0,29]
  end


end

