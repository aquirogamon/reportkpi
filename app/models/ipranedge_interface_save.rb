# == Schema Information
#
# Table name: ipranedge_interface_saves
#
#  id                      :bigint(8)        not null, primary key
#  receivedTotalOctets     :string
#  transmittedTotalOctets  :string
#  timeCaptured            :string
#  periodicTime            :string
#  displayedName           :string
#  monitoredObjectSiteName :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class IpranedgeInterfaceSave < ApplicationRecord
end
