require "rails_helper"

RSpec.describe AccediandevicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/accediandevices").to route_to("accediandevices#index")
    end

    it "routes to #new" do
      expect(:get => "/accediandevices/new").to route_to("accediandevices#new")
    end

    it "routes to #show" do
      expect(:get => "/accediandevices/1").to route_to("accediandevices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/accediandevices/1/edit").to route_to("accediandevices#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/accediandevices").to route_to("accediandevices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/accediandevices/1").to route_to("accediandevices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/accediandevices/1").to route_to("accediandevices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/accediandevices/1").to route_to("accediandevices#destroy", :id => "1")
    end
  end
end
