# == Schema Information
#
# Table name: ipranedge_interfaces
#
#  id           :bigint(8)        not null, primary key
#  devicea      :string
#  porta        :string
#  descriptiona :string
#  egressRate   :float
#  speed        :string
#  gbpsrx       :float
#  gbpstx       :float
#  last_bps_max :float
#  last_status  :float
#  bps_max      :float
#  status       :float
#  crecimiento  :float
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  name_devicea :string
#  deviceb      :string
#  portb        :string
#  name_deviceb :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

require 'rails_helper'

RSpec.describe IpranedgeInterface, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
