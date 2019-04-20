require 'rails_helper'

RSpec.describe "ipranaccess_qosegressinterfaces/show", type: :view do
  before(:each) do
    @ipranaccess_qosegressinterface = assign(:ipranaccess_qosegressinterface, IpranaccessQosegressinterface.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Device/)
    expect(rendered).to match(/Sap/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Device Sap/)
    expect(rendered).to match(/Device Sapqueue/)
  end
end
