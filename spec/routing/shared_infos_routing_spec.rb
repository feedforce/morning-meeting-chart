require "rails_helper"

RSpec.describe SharedInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shared_infos").to route_to("shared_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/shared_infos/new").to route_to("shared_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/shared_infos/1").to route_to("shared_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shared_infos/1/edit").to route_to("shared_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shared_infos").to route_to("shared_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shared_infos/1").to route_to("shared_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shared_infos/1").to route_to("shared_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shared_infos/1").to route_to("shared_infos#destroy", :id => "1")
    end

  end
end
