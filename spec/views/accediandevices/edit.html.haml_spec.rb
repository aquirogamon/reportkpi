require 'rails_helper'

RSpec.describe "accediandevices/edit", type: :view do
  before(:each) do
    @accediandevice = assign(:accediandevice, Accediandevice.create!(
      :site_name => "MyString",
      :name_device => "MyString",
      :type_device => "MyString"
    ))
  end

  it "renders the edit accediandevice form" do
    render

    assert_select "form[action=?][method=?]", accediandevice_path(@accediandevice), "post" do

      assert_select "input[name=?]", "accediandevice[site_name]"

      assert_select "input[name=?]", "accediandevice[name_device]"

      assert_select "input[name=?]", "accediandevice[type_device]"
    end
  end
end
