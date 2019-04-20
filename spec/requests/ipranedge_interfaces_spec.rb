require 'rails_helper'

RSpec.describe "IpranedgeInterfaces", type: :request do
  describe "GET /ipranedge_interfaces" do
    it "works! (now write some real specs)" do
      get ipranedge_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
