require 'rails_helper'

RSpec.describe "cpecac_interfaces/new", type: :view do
  before(:each) do
    assign(:cpecac_interface, CpecacInterface.new(
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
      :gbpsrx_95 => 1.5,
      :gbpstx_95 => 1.5,
      :comment => "MyText",
      :weeks => 1,
      :deviceindex => "MyString",
      :index_opm => "MyString"
    ))
  end

  it "renders new cpecac_interface form" do
    render

    assert_select "form[action=?][method=?]", cpecac_interfaces_path, "post" do

      assert_select "input[name=?]", "cpecac_interface[device]"

      assert_select "input[name=?]", "cpecac_interface[port]"

      assert_select "input[name=?]", "cpecac_interface[servicio]"

      assert_select "input[name=?]", "cpecac_interface[gbpsrx]"

      assert_select "input[name=?]", "cpecac_interface[gbpstx]"

      assert_select "input[name=?]", "cpecac_interface[bps_max]"

      assert_select "input[name=?]", "cpecac_interface[status]"

      assert_select "input[name=?]", "cpecac_interface[last_bps_max]"

      assert_select "input[name=?]", "cpecac_interface[last_status]"

      assert_select "input[name=?]", "cpecac_interface[crecimiento]"

      assert_select "input[name=?]", "cpecac_interface[egressRate]"

      assert_select "input[name=?]", "cpecac_interface[gbpsrx_95]"

      assert_select "input[name=?]", "cpecac_interface[gbpstx_95]"

      assert_select "textarea[name=?]", "cpecac_interface[comment]"

      assert_select "input[name=?]", "cpecac_interface[weeks]"

      assert_select "input[name=?]", "cpecac_interface[deviceindex]"

      assert_select "input[name=?]", "cpecac_interface[index_opm]"
    end
  end
end
