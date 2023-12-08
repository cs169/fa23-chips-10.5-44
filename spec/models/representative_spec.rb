# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:api_response) do
      {
        officials: [
          {
            name:      'Ro Khanna',
            party:     'Democratic Party',
            photo_url: 'https://khanna.house.gov/photo.jpg',
            address:   [
              {
                line1: '306 Cannon House Office Building',
                city:  'Washington',
                state: 'DC',
                zip:   '20515'
              }
            ]
          }
        ],
        offices:   [
          {
            division_id:      'ocd-division/country:us/state:ca/cd:17',
            name:             'U.S. Representative',
            official_indices: [0]
          }
        ]
      }
    end

    before do
      stub_request(:get, /googleapis.com/)
        .to_return(
          status:  200,
          body:    api_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        #JUST NEED TO FIX ALL REFERENCES TO API_RESPONSE SO THAT IT'S VALID
        expect { described_class.civic_api_to_representative_params(api_response.to_json) }
          .to change(described_class, :count).by(1)

        @rep = described_class.last
        expect(@rep.name).to eq('Ro Khanna')
      end

      it 'has the correct fields p1' do
        expect(@rep.address_street).to eq('306 Cannon House Office Building')
        expect(@rep.address_city).to eq('Washington')
        expect(@rep.address_state).to eq('DC')
        expect(@rep.address_zip).to eq('20515')
      end

      it 'has the correct fields p2' do
        expect(@rep.ocdid).to eq('ocd-division/country:us/state:ca/cd:17')
        expect(@rep.title).to eq('U.S. Representative')
        expect(@rep.political_party).to eq('Democratic Party')
        expect(@rep.photo_url).to eq('https://khanna.house.gov/photo.jpg')
      end
    end

    context 'when the representative already exists' do
      let!(:existing_rep) do
        described_class.create!(
          name: 'Ro Khanna', ocdid: 'ocd-division/country:us/state:ca/cd:17',
          title: 'U.S. Representative', political_party: 'Democratic Party',
          address_street: '306 Cannon House Office Building', address_city: 'Washington',
          address_state: 'DC', address_zip: '20515',
          photo_url: 'https://khanna.house.gov/photo.jpg'
        )
      end

      it 'does not create a new representative' do
        expect { described_class.civic_api_to_representative_params(api_response.to_json) }
          .not_to change(described_class, :count)
      end

      it 'updates the existing representative' do
        described_class.civic_api_to_representative_params(api_response.to_json)
        existing_rep.reload
        expect(existing_rep.political_party).to eq('Democratic Party')
        expect(existing_rep.photo_url).to eq('https://khanna.house.gov/photo.jpg')
        # Ensure other fields like ocdid and title remain unchanged.
      end

      it 'has the correct fields p2' do
        expect(existing_rep.address_street).to eq('306 Cannon House Office Building')
        expect(existing_rep.address_city).to eq('Washington')
        expect(existing_rep.address_state).to eq('DC')
        expect(existing_rep.address_zip).to eq('20515')
      end
    end
  end
end
