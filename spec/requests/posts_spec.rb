require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) { get user_posts_path user_id: 1 }
    # response status
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    # template was rendered
    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Posts#index')
    end
  end
  describe 'GET /show' do
    before(:each) { get user_post_path user_id: 1, id: 1 }
    # response status
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    # template was rendered
    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
    # response body includes correct placeholder text
    it 'has the correct placeholder text' do
      expect(response.body).to include('Posts#show')
    end
  end
end
