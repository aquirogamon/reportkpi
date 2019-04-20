require 'rails_helper'

RSpec.describe "accediandevices/index", type: :view do
  before(:each) do
    assign(:accediandevices, [
      Accediandevice.create!(
        :site_name => "Site Name",
        :name_device => "Name Device",
        :type_device => "Type Device"
      ),
      Accediandevice.create!(
        :site_name => "Site Name",
        :name_device => "Name Device",
        :type_device => "Type Device"
      )
    ])
  end

  it "renders a list of accediandevices" do
    render
    assert_select "tr>td", :text => "Site Name".to_s, :count => 2
    assert_select "tr>td", :text => "Name Device".to_s, :count => 2
    assert_select "tr>td", :text => "Type Device".to_s, :count => 2
  end
end
