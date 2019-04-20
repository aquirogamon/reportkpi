require 'rails_helper'

RSpec.describe "sevone_sessions/show", type: :view do
  before(:each) do
    @sevone_session = assign(:sevone_session, SevoneSession.create!(
      :session_name => "Session Name",
      :session_id => 2,
      :object_name => "Object Name",
      :object_id => 3,
      :device_name => "Device Name",
      :device_id => 4,
      :device_elemets => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Session Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Object Name/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Device Name/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
