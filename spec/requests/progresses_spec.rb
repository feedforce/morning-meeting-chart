require 'rails_helper'

RSpec.describe "Progresses", type: :request do
  describe 'GET /teams/:team_id/progress' do
    subject { get "/teams/#{team.id}/progresses" }
    let(:team) { create(:team) }
    it_behaves_like 'HTTP 200 OK'
  end
end
