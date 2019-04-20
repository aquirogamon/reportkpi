require 'rails_helper'

RSpec.describe "internet_interfaces/index", type: :view do
  before(:each) do
    assign(:internet_interfaces, [
      InternetInterface.create!(
        :device => "Device",
        :port => "Port",
        :servicio => "Servicio",
        :gbpsrx => 2.5,
        :gbpstx => 3.5,
        :bps_max => 4.5,
        :last_bps_max => 5.5,
        :last_status => 6.5,
        :crecimiento => 7.5,
        :status => 8.5,
        :egressRate => 9.5,
        :neighbor => "Neighbor",
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex"
      ),
      InternetInterface.create!(
        :device => "Device",
        :port => "Port",
        :servicio => "Servicio",
        :gbpsrx => 2.5,
        :gbpstx => 3.5,
        :bps_max => 4.5,
        :last_bps_max => 5.5,
        :last_status => 6.5,
        :crecimiento => 7.5,
        :status => 8.5,
        :egressRate => 9.5,
        :neighbor => "Neighbor",
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex"
      )
    ])
  end

  it "renders a list of internet_interfaces" do
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
    assert_select "tr>td", :text => "Neighbor".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => "Deviceindex".to_s, :count => 2
  end
end
