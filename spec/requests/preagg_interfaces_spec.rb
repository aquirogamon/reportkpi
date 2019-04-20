require 'rails_helper'

RSpec.describe "PreaggInterfaces", type: :request do
  describe "GET /preagg_interfaces" do
    it "works! (now write some real specs)" do
      get preagg_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
