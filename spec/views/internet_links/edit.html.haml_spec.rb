require 'rails_helper'

RSpec.describe "internet_links/edit", type: :view do
  before(:each) do
    @internet_link = assign(:internet_link, InternetLink.create!(
      :iru => "MyString",
      :tierone => "MyString",
      :location_usa => "MyString",
      :location_peru => "MyString",
      :device => "MyString",
      :port => "MyString",
      :lacp => "MyString",
      :id_iru => "MyString",
      :id_tierone => "MyString",
      :capacity => 1.5,
      :observation => "MyString",
      :time_iru => 1,
      :status => "MyString",
      :name_iru => "MyString",
      :name_tierone => "MyString"
    ))
  end

  it "renders the edit internet_link form" do
    render

    assert_select "form[action=?][method=?]", internet_link_path(@internet_link), "post" do

      assert_select "input[name=?]", "internet_link[iru]"

      assert_select "input[name=?]", "internet_link[tierone]"

      assert_select "input[name=?]", "internet_link[location_usa]"

      assert_select "input[name=?]", "internet_link[location_peru]"

      assert_select "input[name=?]", "internet_link[device]"

      assert_select "input[name=?]", "internet_link[port]"

      assert_select "input[name=?]", "internet_link[lacp]"

      assert_select "input[name=?]", "internet_link[id_iru]"

      assert_select "input[name=?]", "internet_link[id_tierone]"

      assert_select "input[name=?]", "internet_link[capacity]"

      assert_select "input[name=?]", "internet_link[observation]"

      assert_select "input[name=?]", "internet_link[time_iru]"

      assert_select "input[name=?]", "internet_link[status]"

      assert_select "input[name=?]", "internet_link[name_iru]"

      assert_select "input[name=?]", "internet_link[name_tierone]"
    end
  end
end
