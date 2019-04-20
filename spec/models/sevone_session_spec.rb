# == Schema Information
#
# Table name: sevone_sessions
#
#  id             :bigint(8)        not null, primary key
#  session_name   :string
#  session_id     :integer
#  object_name    :string
#  object_id      :integer
#  device_name    :string
#  device_id      :integer
#  device_elemets :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe SevoneSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
