require 'rails_helper'

RSpec.describe "preagg_interfaces/edit", type: :view do
  before(:each) do
    @preagg_interface = assign(:preagg_interface, PreaggInterface.create!(
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
      :deviceindex => "MyString"
    ))
  end

  it "renders the edit preagg_interface form" do
    render

    assert_select "form[action=?][method=?]", preagg_interface_path(@preagg_interface), "post" do

      assert_select "input[name=?]", "preagg_interface[device]"

      assert_select "input[name=?]", "preagg_interface[port]"

      assert_select "input[name=?]", "preagg_interface[servicio]"

      assert_select "input[name=?]", "preagg_interface[gbpsrx]"

      assert_select "input[name=?]", "preagg_interface[gbpstx]"

      assert_select "input[name=?]", "preagg_interface[bps_max]"

      assert_select "input[name=?]", "preagg_interface[status]"

      assert_select "input[name=?]", "preagg_interface[last_bps_max]"

      assert_select "input[name=?]", "preagg_interface[last_status]"

      assert_select "input[name=?]", "preagg_interface[crecimiento]"

      assert_select "input[name=?]", "preagg_interface[egressRate]"

      assert_select "textarea[name=?]", "preagg_interface[comment]"

      assert_select "input[name=?]", "preagg_interface[weeks]"

      assert_select "input[name=?]", "preagg_interface[deviceindex]"
    end
  end
end
