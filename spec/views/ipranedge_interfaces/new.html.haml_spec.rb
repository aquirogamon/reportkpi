require 'rails_helper'

RSpec.describe "ipranedge_interfaces/new", type: :view do
  before(:each) do
    assign(:ipranedge_interface, IpranedgeInterface.new(
      :devicea => "MyString",
      :porta => "MyString",
      :descriptiona => "MyString",
      :egressRate => 1.5,
      :speed => "MyString",
      :gbpsrx => 1.5,
      :gbpstx => 1.5,
      :last_bps_max => 1.5,
      :last_status => 1.5,
      :bps_max => 1.5,
      :status => 1.5,
      :crecimiento => 1.5,
      :comment => "MyText",
      :weeks => 1,
      :deviceindex => "MyString",
      :name_devicea => "MyString",
      :deviceb => "MyString",
      :portb => "MyString",
      :name_deviceb => "MyString"
    ))
  end

  it "renders new ipranedge_interface form" do
    render

    assert_select "form[action=?][method=?]", ipranedge_interfaces_path, "post" do

      assert_select "input[name=?]", "ipranedge_interface[devicea]"

      assert_select "input[name=?]", "ipranedge_interface[porta]"

      assert_select "input[name=?]", "ipranedge_interface[descriptiona]"

      assert_select "input[name=?]", "ipranedge_interface[egressRate]"

      assert_select "input[name=?]", "ipranedge_interface[speed]"

      assert_select "input[name=?]", "ipranedge_interface[gbpsrx]"

      assert_select "input[name=?]", "ipranedge_interface[gbpstx]"

      assert_select "input[name=?]", "ipranedge_interface[last_bps_max]"

      assert_select "input[name=?]", "ipranedge_interface[last_status]"

      assert_select "input[name=?]", "ipranedge_interface[bps_max]"

      assert_select "input[name=?]", "ipranedge_interface[status]"

      assert_select "input[name=?]", "ipranedge_interface[crecimiento]"

      assert_select "textarea[name=?]", "ipranedge_interface[comment]"

      assert_select "input[name=?]", "ipranedge_interface[weeks]"

      assert_select "input[name=?]", "ipranedge_interface[deviceindex]"

      assert_select "input[name=?]", "ipranedge_interface[name_devicea]"

      assert_select "input[name=?]", "ipranedge_interface[deviceb]"

      assert_select "input[name=?]", "ipranedge_interface[portb]"

      assert_select "input[name=?]", "ipranedge_interface[name_deviceb]"
    end
  end
end
