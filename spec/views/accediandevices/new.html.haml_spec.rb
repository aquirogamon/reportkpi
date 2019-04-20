require 'rails_helper'

RSpec.describe "accediandevices/new", type: :view do
  before(:each) do
    assign(:accediandevice, Accediandevice.new(
      :site_name => "MyString",
      :name_device => "MyString",
      :type_device => "MyString"
    ))
  end

  it "renders new accediandevice form" do
    render

    assert_select "form[action=?][method=?]", accediandevices_path, "post" do

      assert_select "input[name=?]", "accediandevice[site_name]"

      assert_select "input[name=?]", "accediandevice[name_device]"

      assert_select "input[name=?]", "accediandevice[type_device]"
    end
  end
end
