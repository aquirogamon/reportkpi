require 'rails_helper'

RSpec.describe "ipranaccess_qosegressinterfaces/new", type: :view do
  before(:each) do
    assign(:ipranaccess_qosegressinterface, IpranaccessQosegressinterface.new(
      :device => "MyString",
      :sap => "MyString",
      :queueId => 1,
      :bps_max => 1.5,
      :discard => 1.5,
      :discard_avg => 1.5,
      :comment => "MyText",
      :weeks => 1,
      :device_sap => "MyString",
      :device_sapqueue => "MyString"
    ))
  end

  it "renders new ipranaccess_qosegressinterface form" do
    render

    assert_select "form[action=?][method=?]", ipranaccess_qosegressinterfaces_path, "post" do

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[device]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[sap]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[queueId]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[bps_max]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[discard]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[discard_avg]"

      assert_select "textarea[name=?]", "ipranaccess_qosegressinterface[comment]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[weeks]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[device_sap]"

      assert_select "input[name=?]", "ipranaccess_qosegressinterface[device_sapqueue]"
    end
  end
end
