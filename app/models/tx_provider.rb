class TxProvider < ApplicationRecord
  has_many :manager_session
  has_many :ipranaccess_qosegressinterface
  has_many :ipranaccess_qosingressinterface
  has_many :iprannet_qosegressinterface
  has_many :iprannet_qosingressinterface
end
