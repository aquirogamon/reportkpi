require 'rails_helper'

RSpec.describe "Accediandevices", type: :request do
  describe "GET /accediandevices" do
    it "works! (now write some real specs)" do
      get accediandevices_path
      expect(response).to have_http_status(200)
    end
  end
end
