# frozen_string_literal: true

# require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    let!(:representative) do
      Representative.create!(
        name:            'Fake Name',
        ocdid:           'ocd-division/country:us/state:ca',
        title:           'fake title',
        political_party: 'Democratic Party',
        address_street:  '123 Street',
        address_city:    'Berkeley',
        address_state:   'CA',
        address_zip:     '94704',
        photo_url:       'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg'
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
      expect(assigns(:representative).name).to eq('Fake Name')
    end

    it 'displays the correct OCD ID' do
      expect(assigns(:representative).ocdid).to eq('ocd-division/country:us/state:ca')
    end

    it 'displays the correct title' do
      expect(assigns(:representative).title).to eq('fake title')
    end

    it 'displays the correct political party' do
      expect(assigns(:representative).political_party).to eq('Democratic Party')
    end

    it 'displays the correct address street' do
      expect(assigns(:representative).address_street).to eq('123 Street')
    end

    it 'displays the correct city' do
      expect(assigns(:representative).address_city).to eq('Berkeley')
    end

    it 'displays the correct state' do
      expect(assigns(:representative).address_state).to eq('CA')
    end

    it 'displays the correct zip code' do
      expect(assigns(:representative).address_zip).to eq('94704')
    end

    it 'displays the correct photo URL' do
      expect(assigns(:representative).photo_url).to eq('https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg')
    end
  end
end
