require 'rails_helper'

RSpec.describe "statusnokia_ports/show", type: :view do
  before(:each) do
    @statusnokia_port = assign(:statusnokia_port, StatusnokiaPort.create!(
      :device => "Device",
      :port => "Port",
      :type_device => "Type Device",
      :configurespeed => "Configurespeed",
      :speed => "Speed",
      :description => "Description",
      :status => "Status",
      :service_all => "Service All"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Device/)
    expect(rendered).to match(/Port/)
    expect(rendered).to match(/Type Device/)
    expect(rendered).to match(/Configurespeed/)
    expect(rendered).to match(/Speed/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Service All/)
  end
end
