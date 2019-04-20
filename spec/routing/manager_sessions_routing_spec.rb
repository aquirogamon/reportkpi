require "rails_helper"

RSpec.describe ManagerSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/manager_sessions").to route_to("manager_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/manager_sessions/new").to route_to("manager_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/manager_sessions/1").to route_to("manager_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/manager_sessions/1/edit").to route_to("manager_sessions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/manager_sessions").to route_to("manager_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/manager_sessions/1").to route_to("manager_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/manager_sessions/1").to route_to("manager_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/manager_sessions/1").to route_to("manager_sessions#destroy", :id => "1")
    end
  end
end
