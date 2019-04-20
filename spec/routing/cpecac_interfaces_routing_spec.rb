require "rails_helper"

RSpec.describe CpecacInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cpecac_interfaces").to route_to("cpecac_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/cpecac_interfaces/new").to route_to("cpecac_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/cpecac_interfaces/1").to route_to("cpecac_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cpecac_interfaces/1/edit").to route_to("cpecac_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cpecac_interfaces").to route_to("cpecac_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cpecac_interfaces/1").to route_to("cpecac_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cpecac_interfaces/1").to route_to("cpecac_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cpecac_interfaces/1").to route_to("cpecac_interfaces#destroy", :id => "1")
    end
  end
end
