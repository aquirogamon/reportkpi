require 'rails_helper'

RSpec.describe "core_interfaces/edit", type: :view do
  before(:each) do
    @core_interface = assign(:core_interface, CoreInterface.create!(
      :device => "MyString",
      :port => "MyString",
      :servicio => "MyString",
      :gbpsrx => 1.5,
      :gbpstx => 1.5,
      :bps_max => 1.5,
      :status => 1.5,
      :last_bps_max => 1.5,
      :last_status => 1.5,
      :crecimiento => 1.5,
      :egressRate => 1.5,
      :comment => "MyText",
      :weeks => 1,
      :deviceindex => "MyString",
      :location => "MyString",
      :router => "MyString"
    ))
  end

  it "renders the edit core_interface form" do
    render

    assert_select "form[action=?][method=?]", core_interface_path(@core_interface), "post" do

      assert_select "input[name=?]", "core_interface[device]"

      assert_select "input[name=?]", "core_interface[port]"

      assert_select "input[name=?]", "core_interface[servicio]"

      assert_select "input[name=?]", "core_interface[gbpsrx]"

      assert_select "input[name=?]", "core_interface[gbpstx]"

      assert_select "input[name=?]", "core_interface[bps_max]"

      assert_select "input[name=?]", "core_interface[status]"

      assert_select "input[name=?]", "core_interface[last_bps_max]"

      assert_select "input[name=?]", "core_interface[last_status]"

      assert_select "input[name=?]", "core_interface[crecimiento]"

      assert_select "input[name=?]", "core_interface[egressRate]"

      assert_select "textarea[name=?]", "core_interface[comment]"

      assert_select "input[name=?]", "core_interface[weeks]"

      assert_select "input[name=?]", "core_interface[deviceindex]"

      assert_select "input[name=?]", "core_interface[location]"

      assert_select "input[name=?]", "core_interface[router]"
    end
  end
end
