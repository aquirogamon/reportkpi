require 'rails_helper'

RSpec.describe "StatusnokiaPorts", type: :request do
  describe "GET /statusnokia_ports" do
    it "works! (now write some real specs)" do
      get statusnokia_ports_path
      expect(response).to have_http_status(200)
    end
  end
end
