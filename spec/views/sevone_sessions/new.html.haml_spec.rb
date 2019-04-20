require 'rails_helper'

RSpec.describe "sevone_sessions/new", type: :view do
  before(:each) do
    assign(:sevone_session, SevoneSession.new(
      :session_name => "MyString",
      :session_id => 1,
      :object_name => "MyString",
      :object_id => 1,
      :device_name => "MyString",
      :device_id => 1,
      :device_elemets => 1
    ))
  end

  it "renders new sevone_session form" do
    render

    assert_select "form[action=?][method=?]", sevone_sessions_path, "post" do

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
