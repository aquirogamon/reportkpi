require "rails_helper"

RSpec.describe SevoneSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sevone_sessions").to route_to("sevone_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/sevone_sessions/new").to route_to("sevone_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/sevone_sessions/1").to route_to("sevone_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sevone_sessions/1/edit").to route_to("sevone_sessions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sevone_sessions").to route_to("sevone_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sevone_sessions/1").to route_to("sevone_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sevone_sessions/1").to route_to("sevone_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sevone_sessions/1").to route_to("sevone_sessions#destroy", :id => "1")
    end
  end
end
