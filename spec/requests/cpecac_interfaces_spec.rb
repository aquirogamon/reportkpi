require 'rails_helper'

RSpec.describe "CpecacInterfaces", type: :request do
  describe "GET /cpecac_interfaces" do
    it "works! (now write some real specs)" do
      get cpecac_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
