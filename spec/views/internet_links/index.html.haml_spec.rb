require 'rails_helper'

RSpec.describe "internet_links/index", type: :view do
  before(:each) do
    assign(:internet_links, [
      InternetLink.create!(
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
      ),
      InternetLink.create!(
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
      )
    ])
  end

  it "renders a list of internet_links" do
    render
    assert_select "tr>td", :text => "Iru".to_s, :count => 2
    assert_select "tr>td", :text => "Tierone".to_s, :count => 2
    assert_select "tr>td", :text => "Location Usa".to_s, :count => 2
    assert_select "tr>td", :text => "Location Peru".to_s, :count => 2
    assert_select "tr>td", :text => "Device".to_s, :count => 2
    assert_select "tr>td", :text => "Port".to_s, :count => 2
    assert_select "tr>td", :text => "Lacp".to_s, :count => 2
    assert_select "tr>td", :text => "Id Iru".to_s, :count => 2
    assert_select "tr>td", :text => "Id Tierone".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Observation".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Name Iru".to_s, :count => 2
    assert_select "tr>td", :text => "Name Tierone".to_s, :count => 2
  end
end
