require 'rails_helper'

RSpec.describe "internet_interfaces/edit", type: :view do
  before(:each) do
    @internet_interface = assign(:internet_interface, InternetInterface.create!(
      :device => "MyString",
      :port => "MyString",
      :servicio => "MyString",
      :gbpsrx => 1.5,
      :gbpstx => 1.5,
      :bps_max => 1.5,
      :last_bps_max => 1.5,
      :last_status => 1.5,
      :crecimiento => 1.5,
      :status => 1.5,
      :egressRate => 1.5,
      :neighbor => "MyString",
      :comment => "MyText",
      :weeks => 1,
      :deviceindex => "MyString"
    ))
  end

  it "renders the edit internet_interface form" do
    render

    assert_select "form[action=?][method=?]", internet_interface_path(@internet_interface), "post" do

      assert_select "input[name=?]", "internet_interface[device]"

      assert_select "input[name=?]", "internet_interface[port]"

      assert_select "input[name=?]", "internet_interface[servicio]"

      assert_select "input[name=?]", "internet_interface[gbpsrx]"

      assert_select "input[name=?]", "internet_interface[gbpstx]"

      assert_select "input[name=?]", "internet_interface[bps_max]"

      assert_select "input[name=?]", "internet_interface[last_bps_max]"

      assert_select "input[name=?]", "internet_interface[last_status]"

      assert_select "input[name=?]", "internet_interface[crecimiento]"

      assert_select "input[name=?]", "internet_interface[status]"

      assert_select "input[name=?]", "internet_interface[egressRate]"

      assert_select "input[name=?]", "internet_interface[neighbor]"

      assert_select "textarea[name=?]", "internet_interface[comment]"

      assert_select "input[name=?]", "internet_interface[weeks]"

      assert_select "input[name=?]", "internet_interface[deviceindex]"
    end
  end
end
