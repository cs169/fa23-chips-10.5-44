# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    let!(:representative) do
      Representative.create!(
        name:            'Ro Khanna',
        ocdid:           'ocd-division/country:us/state:ca/cd:17',
        title:           'U.S. Representative',
        political_party: 'Democratic Party',
        address_street:  '306 Cannon House Office Building',
        address_city:    'Washington',
        address_state:   'DC',
        address_zip:     '20515',
        photo_url:       'https://khanna.house.gov/photo.jpg'
      )
    end

    before { get :show, params: { id: representative.id } }

    it 'assigns @representative' do
      expect(assigns(:representative)).to eq(representative)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'displays the correct name' do
      expect(assigns(:representative).name).to eq('Ro Khanna')
    end

    it 'displays the correct OCD ID' do
      expect(assigns(:representative).ocdid).to eq('ocd-division/country:us/state:ca/cd:17')
    end

    it 'displays the correct title' do
      expect(assigns(:representative).title).to eq('U.S. Representative')
    end

    it 'displays the correct political party' do
      expect(assigns(:representative).political_party).to eq('Democratic Party')
    end

    it 'displays the correct address street' do
      expect(assigns(:representative).address_street).to eq('306 Cannon House Office Building')
    end

    it 'displays the correct city' do
      expect(assigns(:representative).address_city).to eq('Washington')
    end

    it 'displays the correct state' do
      expect(assigns(:representative).address_state).to eq('DC')
    end

    it 'displays the correct zip code' do
      expect(assigns(:representative).address_zip).to eq('20515')
    end

    it 'displays the correct photo URL' do
      expect(assigns(:representative).photo_url).to eq('https://khanna.house.gov/photo.jpg')
    end
  end
end
