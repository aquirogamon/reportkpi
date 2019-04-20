require 'rails_helper'

RSpec.describe "internet_links/show", type: :view do
  before(:each) do
    @internet_link = assign(:internet_link, InternetLink.create!(
      :iru => "Iru",
      :tierone => "Tierone",
      :location_usa => "Location Usa",
      :location_peru => "Location Peru",
      :device => "Device",
      :port => "Port",
      :lacp => "Lacp",
      :id_iru => "Id Iru",
      :id_tierone => "Id Tierone",
      :capacity => 2.5,
      :observation => "Observation",
      :time_iru => 3,
      :status => "Status",
      :name_iru => "Name Iru",
      :name_tierone => "Name Tierone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Iru/)
    expect(rendered).to match(/Tierone/)
    expect(rendered).to match(/Location Usa/)
    expect(rendered).to match(/Location Peru/)
    expect(rendered).to match(/Device/)
    expect(rendered).to match(/Port/)
    expect(rendered).to match(/Lacp/)
    expect(rendered).to match(/Id Iru/)
    expect(rendered).to match(/Id Tierone/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Observation/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Name Iru/)
    expect(rendered).to match(/Name Tierone/)
  end
end
