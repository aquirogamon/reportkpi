require "rails_helper"

RSpec.describe IpranedgeInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ipranedge_interfaces").to route_to("ipranedge_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/ipranedge_interfaces/new").to route_to("ipranedge_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/ipranedge_interfaces/1").to route_to("ipranedge_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ipranedge_interfaces/1/edit").to route_to("ipranedge_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ipranedge_interfaces").to route_to("ipranedge_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ipranedge_interfaces/1").to route_to("ipranedge_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ipranedge_interfaces/1").to route_to("ipranedge_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ipranedge_interfaces/1").to route_to("ipranedge_interfaces#destroy", :id => "1")
    end
  end
end
