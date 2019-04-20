# == Schema Information
#
# Table name: core_interfaces
#
#  id           :bigint(8)        not null, primary key
#  device       :string
#  port         :string
#  servicio     :string
#  gbpsrx       :float
#  gbpstx       :float
#  bps_max      :float
#  status       :float
#  last_bps_max :float
#  last_status  :float
#  crecimiento  :float
#  egressRate   :float
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  location     :string
#  router       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

require 'rails_helper'

RSpec.describe CoreInterface, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
