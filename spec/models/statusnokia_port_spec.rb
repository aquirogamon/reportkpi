# == Schema Information
#
# Table name: statusnokia_ports
#
#  id             :bigint(8)        not null, primary key
#  device         :string
#  port           :string
#  type_device    :string
#  configurespeed :string
#  speed          :string
#  description    :string
#  status         :string
#  service_all    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe StatusnokiaPort, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
