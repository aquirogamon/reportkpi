require 'rails_helper'

RSpec.describe "SevoneSessions", type: :request do
  describe "GET /sevone_sessions" do
    it "works! (now write some real specs)" do
      get sevone_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
