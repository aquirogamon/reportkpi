require 'rails_helper'

RSpec.describe "InternetLinks", type: :request do
  describe "GET /internet_links" do
    it "works! (now write some real specs)" do
      get internet_links_path
      expect(response).to have_http_status(200)
    end
  end
end
