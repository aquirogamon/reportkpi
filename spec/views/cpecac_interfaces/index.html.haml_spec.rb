require 'rails_helper'

RSpec.describe "cpecac_interfaces/index", type: :view do
  before(:each) do
    assign(:cpecac_interfaces, [
      CpecacInterface.create!(
        :device => "Device",
        :port => "Port",
        :servicio => "Servicio",
        :gbpsrx => 2.5,
        :gbpstx => 3.5,
        :bps_max => 4.5,
        :status => 5.5,
        :last_bps_max => 6.5,
        :last_status => 7.5,
        :crecimiento => 8.5,
        :egressRate => 9.5,
        :gbpsrx_95 => 10.5,
        :gbpstx_95 => 11.5,
        :comment => "MyText",
        :weeks => 12,
        :deviceindex => "Deviceindex",
        :index_opm => "Index Opm"
      ),
      CpecacInterface.create!(
        :device => "Device",
        :port => "Port",
        :servicio => "Servicio",
        :gbpsrx => 2.5,
        :gbpstx => 3.5,
        :bps_max => 4.5,
        :status => 5.5,
        :last_bps_max => 6.5,
        :last_status => 7.5,
        :crecimiento => 8.5,
        :egressRate => 9.5,
        :gbpsrx_95 => 10.5,
        :gbpstx_95 => 11.5,
        :comment => "MyText",
        :weeks => 12,
        :deviceindex => "Deviceindex",
        :index_opm => "Index Opm"
      )
    ])
  end

  it "renders a list of cpecac_interfaces" do
    render
    assert_select "tr>td", :text => "Device".to_s, :count => 2
    assert_select "tr>td", :text => "Port".to_s, :count => 2
    assert_select "tr>td", :text => "Servicio".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
    assert_select "tr>td", :text => 10.5.to_s, :count => 2
    assert_select "tr>td", :text => 11.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
    assert_select "tr>td", :text => "Deviceindex".to_s, :count => 2
    assert_select "tr>td", :text => "Index Opm".to_s, :count => 2
  end
end
