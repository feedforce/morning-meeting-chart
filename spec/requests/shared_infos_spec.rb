require 'rails_helper'

RSpec.describe "SharedInfos", type: :request do
  describe "GET /shared_infos" do
    it "works! (now write some real specs)" do
      get shared_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
