# == Schema Information
#
# Table name: providers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Provider < ApplicationRecord
  has_many :preagg_interface
  has_many :internet_interface
  has_many :core_interface
end
