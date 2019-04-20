require 'rails_helper'

RSpec.describe "sevone_sessions/index", type: :view do
  before(:each) do
    assign(:sevone_sessions, [
      SevoneSession.create!(
        :session_name => "Session Name",
        :session_id => 2,
        :object_name => "Object Name",
        :object_id => 3,
        :device_name => "Device Name",
        :device_id => 4,
        :device_elemets => 5
      ),
      SevoneSession.create!(
        :session_name => "Session Name",
        :session_id => 2,
        :object_name => "Object Name",
        :object_id => 3,
        :device_name => "Device Name",
        :device_id => 4,
        :device_elemets => 5
      )
    ])
  end

  it "renders a list of sevone_sessions" do
    render
    assert_select "tr>td", :text => "Session Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Object Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Device Name".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
