# == Schema Information
#
# Table name: accediandevices
#
#  id          :bigint(8)        not null, primary key
#  site_name   :string
#  name_device :string
#  type_device :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Accediandevice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
