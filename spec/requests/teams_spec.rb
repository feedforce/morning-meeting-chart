require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe 'GET /teams' do
    subject { get '/teams' }
    let(:template) { 'index' }

    it_behaves_like 'HTTP 200 OK'
    it_behaves_like 'render template'
  end
end
