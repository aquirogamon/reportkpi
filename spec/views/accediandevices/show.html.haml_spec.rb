require 'rails_helper'

RSpec.describe "accediandevices/show", type: :view do
  before(:each) do
    @accediandevice = assign(:accediandevice, Accediandevice.create!(
      :site_name => "Site Name",
      :name_device => "Name Device",
      :type_device => "Type Device"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Site Name/)
    expect(rendered).to match(/Name Device/)
    expect(rendered).to match(/Type Device/)
  end
end
