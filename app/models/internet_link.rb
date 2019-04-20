# == Schema Information
#
# Table name: internet_links
#
#  id              :bigint(8)        not null, primary key
#  iru             :string
#  tierone         :string
#  location_usa    :string
#  location_peru   :string
#  device          :string
#  port            :string
#  lacp            :string
#  id_iru          :string
#  id_tierone      :string
#  capacity        :float
#  observation     :string
#  time_activation :date
#  time_iru        :integer          default(0)
#  time_rest       :date
#  status          :string
#  name_iru        :string
#  name_tierone    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class InternetLink < ApplicationRecord

	after_validation :update_time

  private

  def update_time
    self.time_rest = self.time_activation + (self.time_iru).month
  end

end
