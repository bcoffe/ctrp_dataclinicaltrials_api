require 'rails_helper'

RSpec.describe "DataClinicalTrails", type: :request do
  describe "GET /data_clinical_trails" do
    it "works! (now write some real specs)" do
      get data_clinical_trails_path
      expect(response).to have_http_status(200)
    end
  end
end
