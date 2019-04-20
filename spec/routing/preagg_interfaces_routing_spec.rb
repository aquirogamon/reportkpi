require "rails_helper"

RSpec.describe PreaggInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/preagg_interfaces").to route_to("preagg_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/preagg_interfaces/new").to route_to("preagg_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/preagg_interfaces/1").to route_to("preagg_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/preagg_interfaces/1/edit").to route_to("preagg_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/preagg_interfaces").to route_to("preagg_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/preagg_interfaces/1").to route_to("preagg_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/preagg_interfaces/1").to route_to("preagg_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/preagg_interfaces/1").to route_to("preagg_interfaces#destroy", :id => "1")
    end
  end
end
