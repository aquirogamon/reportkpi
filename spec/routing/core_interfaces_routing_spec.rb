require "rails_helper"

RSpec.describe CoreInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/core_interfaces").to route_to("core_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/core_interfaces/new").to route_to("core_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/core_interfaces/1").to route_to("core_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/core_interfaces/1/edit").to route_to("core_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/core_interfaces").to route_to("core_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/core_interfaces/1").to route_to("core_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/core_interfaces/1").to route_to("core_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/core_interfaces/1").to route_to("core_interfaces#destroy", :id => "1")
    end
  end
end
