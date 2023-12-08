# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    let!(:representative) do
      Representative.create!(
        name: 'John Doe', ocdid: 'ocd_id', title: 'Senator',
        political_party: 'Independent', address_street: '123 Main St',
        address_city: 'Anytown', address_state: 'CA',
        address_zip: '12345', photo_url: 'http://example.com/photo.jpg'
      )
    end

    before { get :show, params: { id: representative.id } }

    it 'assigns @representative' do
      expect(assigns(:representative)).to eq(representative)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end
