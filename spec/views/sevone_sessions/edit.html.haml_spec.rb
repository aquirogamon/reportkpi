require 'rails_helper'

RSpec.describe "sevone_sessions/edit", type: :view do
  before(:each) do
    @sevone_session = assign(:sevone_session, SevoneSession.create!(
      :session_name => "MyString",
      :session_id => 1,
      :object_name => "MyString",
      :object_id => 1,
      :device_name => "MyString",
      :device_id => 1,
      :device_elemets => 1
    ))
  end

  it "renders the edit sevone_session form" do
    render

    assert_select "form[action=?][method=?]", sevone_session_path(@sevone_session), "post" do

      assert_select "input[name=?]", "sevone_session[session_name]"

      assert_select "input[name=?]", "sevone_session[session_id]"

      assert_select "input[name=?]", "sevone_session[object_name]"

      assert_select "input[name=?]", "sevone_session[object_id]"

      assert_select "input[name=?]", "sevone_session[device_name]"

      assert_select "input[name=?]", "sevone_session[device_id]"

      assert_select "input[name=?]", "sevone_session[device_elemets]"
    end
  end
end
