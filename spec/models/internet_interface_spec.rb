# == Schema Information
#
# Table name: internet_interfaces
#
#  id           :bigint(8)        not null, primary key
#  device       :string
#  port         :string
#  servicio     :string
#  gbpsrx       :float
#  gbpstx       :float
#  bps_max      :float
#  last_bps_max :float
#  last_status  :float
#  crecimiento  :float
#  status       :float
#  egressRate   :float
#  neighbor     :string
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

require 'rails_helper'

RSpec.describe InternetInterface, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
