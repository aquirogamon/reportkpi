require "rails_helper"

RSpec.describe InternetInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/internet_interfaces").to route_to("internet_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/internet_interfaces/new").to route_to("internet_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/internet_interfaces/1").to route_to("internet_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/internet_interfaces/1/edit").to route_to("internet_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/internet_interfaces").to route_to("internet_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/internet_interfaces/1").to route_to("internet_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/internet_interfaces/1").to route_to("internet_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/internet_interfaces/1").to route_to("internet_interfaces#destroy", :id => "1")
    end
  end
end
