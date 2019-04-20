require 'rails_helper'

RSpec.describe "CoreInterfaces", type: :request do
  describe "GET /core_interfaces" do
    it "works! (now write some real specs)" do
      get core_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
