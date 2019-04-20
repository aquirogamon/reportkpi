require 'rails_helper'

RSpec.describe "statusnokia_ports/index", type: :view do
  before(:each) do
    assign(:statusnokia_ports, [
      StatusnokiaPort.create!(
        :device => "Device",
        :port => "Port",
        :type_device => "Type Device",
        :configurespeed => "Configurespeed",
        :speed => "Speed",
        :description => "Description",
        :status => "Status",
        :service_all => "Service All"
      ),
      StatusnokiaPort.create!(
        :device => "Device",
        :port => "Port",
        :type_device => "Type Device",
        :configurespeed => "Configurespeed",
        :speed => "Speed",
        :description => "Description",
        :status => "Status",
        :service_all => "Service All"
      )
    ])
  end

  it "renders a list of statusnokia_ports" do
    render
    assert_select "tr>td", :text => "Device".to_s, :count => 2
    assert_select "tr>td", :text => "Port".to_s, :count => 2
    assert_select "tr>td", :text => "Type Device".to_s, :count => 2
    assert_select "tr>td", :text => "Configurespeed".to_s, :count => 2
    assert_select "tr>td", :text => "Speed".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Service All".to_s, :count => 2
  end
end
