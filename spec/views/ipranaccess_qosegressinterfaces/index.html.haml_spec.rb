require 'rails_helper'

RSpec.describe "ipranaccess_qosegressinterfaces/index", type: :view do
  before(:each) do
    assign(:ipranaccess_qosegressinterfaces, [
      IpranaccessQosegressinterface.create!(
        :device => "Device",
        :sap => "Sap",
        :queueId => 2,
        :bps_max => 3.5,
        :discard => 4.5,
        :discard_avg => 5.5,
        :comment => "MyText",
        :weeks => 6,
        :device_sap => "Device Sap",
        :device_sapqueue => "Device Sapqueue"
      ),
      IpranaccessQosegressinterface.create!(
        :device => "Device",
        :sap => "Sap",
        :queueId => 2,
        :bps_max => 3.5,
        :discard => 4.5,
        :discard_avg => 5.5,
        :comment => "MyText",
        :weeks => 6,
        :device_sap => "Device Sap",
        :device_sapqueue => "Device Sapqueue"
      )
    ])
  end

  it "renders a list of ipranaccess_qosegressinterfaces" do
    render
    assert_select "tr>td", :text => "Device".to_s, :count => 2
    assert_select "tr>td", :text => "Sap".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Device Sap".to_s, :count => 2
    assert_select "tr>td", :text => "Device Sapqueue".to_s, :count => 2
  end
end
