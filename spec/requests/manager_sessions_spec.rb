require 'rails_helper'

RSpec.describe "ManagerSessions", type: :request do
  describe "GET /manager_sessions" do
    it "works! (now write some real specs)" do
      get manager_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
