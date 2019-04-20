# == Schema Information
#
# Table name: cpecac_interfaces
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
#  gbpsrx_95    :float
#  gbpstx_95    :float
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  index_opm    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe CpecacInterface, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
