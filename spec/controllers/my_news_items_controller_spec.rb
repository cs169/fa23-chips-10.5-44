# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { instance_double(Representative, id: 1) }
  let(:news_item) { instance_double(NewsItem, representative: representative) }

  # PROBLEM: requires user to login before any actions. Not sure if this way is valid.
  before do
    user_double = User.create(provider: 1, uid: '123')
    session[:current_user_id] = user_double.id
    @rep_double = Representative.create(name: 'fake_name')
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { representative_id: @rep_double }
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      # render edit
    end
  end

  describe 'GET #select_news' do
    it 'renders the select_form template' do
      # check get#select_form
      # test api call? stub out
    end
  end

  describe 'POST #create' do
    it 'creates a new NewsItem' do
      # check post#create
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        # check new
      end
    end
  end

  describe 'PATCH #update' do
    it 'updates the NewsItem' do
      # check patch#update
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        # check edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the NewsItem' do
      # delete
    end
  end
end
