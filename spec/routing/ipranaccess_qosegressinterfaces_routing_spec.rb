require "rails_helper"

RSpec.describe IpranaccessQosegressinterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ipranaccess_qosegressinterfaces").to route_to("ipranaccess_qosegressinterfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/ipranaccess_qosegressinterfaces/new").to route_to("ipranaccess_qosegressinterfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/ipranaccess_qosegressinterfaces/1").to route_to("ipranaccess_qosegressinterfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ipranaccess_qosegressinterfaces/1/edit").to route_to("ipranaccess_qosegressinterfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ipranaccess_qosegressinterfaces").to route_to("ipranaccess_qosegressinterfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ipranaccess_qosegressinterfaces/1").to route_to("ipranaccess_qosegressinterfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ipranaccess_qosegressinterfaces/1").to route_to("ipranaccess_qosegressinterfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ipranaccess_qosegressinterfaces/1").to route_to("ipranaccess_qosegressinterfaces#destroy", :id => "1")
    end
  end
end
