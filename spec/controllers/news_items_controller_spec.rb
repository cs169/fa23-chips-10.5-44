# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:user) do
    User.create!(uid: '12345', provider: 'google_oauth2', first_name: 'Test', last_name: 'User',
                 email: 'test@example.com')
  end
  let(:representative) { Representative.create!(name: 'Rep Name', political_party: 'Independent') }
  let(:news_item) do
    NewsItem.create!(title: 'Test News', description: 'Test Description', link: 'http://test.com',
                     representative: representative)
  end

  before do
    # Mock a logged-in user
    allow(controller).to receive(:session).and_return({ current_user_id: user.id })
  end

  describe 'GET #index' do
    it 'assigns @news_items and renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested news_item and renders the show template' do
      get :show, params: { id: news_item.id, representative_id: representative.id }
      expect(assigns(:news_item)).to eq(news_item)
      expect(response).to render_template(:show)
    end
  end
end
