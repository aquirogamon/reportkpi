require 'rails_helper'

RSpec.describe "statusnokia_ports/new", type: :view do
  before(:each) do
    assign(:statusnokia_port, StatusnokiaPort.new(
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

  it "renders new statusnokia_port form" do
    render

    assert_select "form[action=?][method=?]", statusnokia_ports_path, "post" do

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
