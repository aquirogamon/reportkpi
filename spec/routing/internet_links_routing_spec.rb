require "rails_helper"

RSpec.describe InternetLinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/internet_links").to route_to("internet_links#index")
    end

    it "routes to #new" do
      expect(:get => "/internet_links/new").to route_to("internet_links#new")
    end

    it "routes to #show" do
      expect(:get => "/internet_links/1").to route_to("internet_links#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/internet_links/1/edit").to route_to("internet_links#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/internet_links").to route_to("internet_links#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/internet_links/1").to route_to("internet_links#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/internet_links/1").to route_to("internet_links#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/internet_links/1").to route_to("internet_links#destroy", :id => "1")
    end
  end
end
