require 'rails_helper'

RSpec.describe "internet_interfaces/show", type: :view do
  before(:each) do
    @internet_interface = assign(:internet_interface, InternetInterface.create!(
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
    expect(rendered).to match(/Neighbor/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/Deviceindex/)
  end
end
