require "rails_helper"

RSpec.describe StatusnokiaPortsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/statusnokia_ports").to route_to("statusnokia_ports#index")
    end

    it "routes to #new" do
      expect(:get => "/statusnokia_ports/new").to route_to("statusnokia_ports#new")
    end

    it "routes to #show" do
      expect(:get => "/statusnokia_ports/1").to route_to("statusnokia_ports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/statusnokia_ports/1/edit").to route_to("statusnokia_ports#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/statusnokia_ports").to route_to("statusnokia_ports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/statusnokia_ports/1").to route_to("statusnokia_ports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/statusnokia_ports/1").to route_to("statusnokia_ports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/statusnokia_ports/1").to route_to("statusnokia_ports#destroy", :id => "1")
    end
  end
end
