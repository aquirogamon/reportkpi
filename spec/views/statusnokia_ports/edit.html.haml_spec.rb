require 'rails_helper'

RSpec.describe "statusnokia_ports/edit", type: :view do
  before(:each) do
    @statusnokia_port = assign(:statusnokia_port, StatusnokiaPort.create!(
      :device => "MyString",
      :port => "MyString",
      :type_device => "MyString",
      :configurespeed => "MyString",
      :speed => "MyString",
      :description => "MyString",
      :status => "MyString",
      :service_all => "MyString"
    ))
  end

  it "renders the edit statusnokia_port form" do
    render

    assert_select "form[action=?][method=?]", statusnokia_port_path(@statusnokia_port), "post" do

      assert_select "input[name=?]", "statusnokia_port[device]"

      assert_select "input[name=?]", "statusnokia_port[port]"

      assert_select "input[name=?]", "statusnokia_port[type_device]"

      assert_select "input[name=?]", "statusnokia_port[configurespeed]"

      assert_select "input[name=?]", "statusnokia_port[speed]"

      assert_select "input[name=?]", "statusnokia_port[description]"

      assert_select "input[name=?]", "statusnokia_port[status]"

      assert_select "input[name=?]", "statusnokia_port[service_all]"
    end
  end
end
