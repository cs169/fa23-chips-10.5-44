# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #login' do
    context 'when not logged in' do
      before { get :login }

      it 'renders the login template' do
        expect(response).to render_template('login')
      end
    end
  end

  describe 'POST #google_oauth2' do
    context 'with invalid credentials (google_oauth2)' do
      it 'does not set the session current user id' do
        request.env['omniauth.auth'] = nil # Simulate invalid credentials
        post :google_oauth2
        expect(session[:current_user_id]).to be_nil
      end
    end
  end

  describe 'POST #github' do
    context 'with invalid credentials (github)' do
      it 'does not set the session current user id' do
        request.env['omniauth.auth'] = nil # Simulate invalid credentials
        post :github
        expect(session[:current_user_id]).to be_nil
      end
    end
  end

  describe 'GET #logout' do
    before do
      session[:current_user_id] = 1 # Simulate a logged-in user
      get :logout
    end

    it 'clears the session and redirects to root' do
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
