require 'rails_helper'

RSpec.describe "ipranedge_interfaces/show", type: :view do
  before(:each) do
    @ipranedge_interface = assign(:ipranedge_interface, IpranedgeInterface.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Devicea/)
    expect(rendered).to match(/Porta/)
    expect(rendered).to match(/Descriptiona/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Speed/)
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
    expect(rendered).to match(/Name Devicea/)
    expect(rendered).to match(/Deviceb/)
    expect(rendered).to match(/Portb/)
    expect(rendered).to match(/Name Deviceb/)
  end
end
