require 'rails_helper'

RSpec.describe "core_interfaces/index", type: :view do
  before(:each) do
    assign(:core_interfaces, [
      CoreInterface.create!(
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
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex",
        :location => "Location",
        :router => "Router"
      ),
      CoreInterface.create!(
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
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex",
        :location => "Location",
        :router => "Router"
      )
    ])
  end

  it "renders a list of core_interfaces" do
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
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => "Deviceindex".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Router".to_s, :count => 2
  end
end
