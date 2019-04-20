require 'rails_helper'

RSpec.describe "core_interfaces/show", type: :view do
  before(:each) do
    @core_interface = assign(:core_interface, CoreInterface.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Device/)
    expect(rendered).to match(/Port/)
    expect(rendered).to match(/Servicio/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/Deviceindex/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Router/)
  end
end
