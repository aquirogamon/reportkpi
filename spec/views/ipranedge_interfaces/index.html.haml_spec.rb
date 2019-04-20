require 'rails_helper'

RSpec.describe "ipranedge_interfaces/index", type: :view do
  before(:each) do
    assign(:ipranedge_interfaces, [
      IpranedgeInterface.create!(
        :devicea => "Devicea",
        :porta => "Porta",
        :descriptiona => "Descriptiona",
        :egressRate => 2.5,
        :speed => "Speed",
        :gbpsrx => 3.5,
        :gbpstx => 4.5,
        :last_bps_max => 5.5,
        :last_status => 6.5,
        :bps_max => 7.5,
        :status => 8.5,
        :crecimiento => 9.5,
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex",
        :name_devicea => "Name Devicea",
        :deviceb => "Deviceb",
        :portb => "Portb",
        :name_deviceb => "Name Deviceb"
      ),
      IpranedgeInterface.create!(
        :devicea => "Devicea",
        :porta => "Porta",
        :descriptiona => "Descriptiona",
        :egressRate => 2.5,
        :speed => "Speed",
        :gbpsrx => 3.5,
        :gbpstx => 4.5,
        :last_bps_max => 5.5,
        :last_status => 6.5,
        :bps_max => 7.5,
        :status => 8.5,
        :crecimiento => 9.5,
        :comment => "MyText",
        :weeks => 10,
        :deviceindex => "Deviceindex",
        :name_devicea => "Name Devicea",
        :deviceb => "Deviceb",
        :portb => "Portb",
        :name_deviceb => "Name Deviceb"
      )
    ])
  end

  it "renders a list of ipranedge_interfaces" do
    render
    assert_select "tr>td", :text => "Devicea".to_s, :count => 2
    assert_select "tr>td", :text => "Porta".to_s, :count => 2
    assert_select "tr>td", :text => "Descriptiona".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Speed".to_s, :count => 2
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
    assert_select "tr>td", :text => "Name Devicea".to_s, :count => 2
    assert_select "tr>td", :text => "Deviceb".to_s, :count => 2
    assert_select "tr>td", :text => "Portb".to_s, :count => 2
    assert_select "tr>td", :text => "Name Deviceb".to_s, :count => 2
  end
end
