require "rails_helper"

RSpec.describe DataClinicalTrailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_clinical_trails").to route_to("data_clinical_trails#index")
    end

    it "routes to #new" do
      expect(:get => "/data_clinical_trails/new").to route_to("data_clinical_trails#new")
    end

    it "routes to #show" do
      expect(:get => "/data_clinical_trails/1").to route_to("data_clinical_trails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_clinical_trails/1/edit").to route_to("data_clinical_trails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_clinical_trails").to route_to("data_clinical_trails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_clinical_trails/1").to route_to("data_clinical_trails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_clinical_trails/1").to route_to("data_clinical_trails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_clinical_trails/1").to route_to("data_clinical_trails#destroy", :id => "1")
    end

  end
end
