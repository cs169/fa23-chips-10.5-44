# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'
require 'ostruct'
require 'google/apis/civicinfo_v2'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:civic_info_service) { instance_double(Google::Apis::CivicinfoV2::CivicInfoService) }
    let(:api_response) do
      OpenStruct.new(
        officials: [
          OpenStruct.new(
            name:      'Ro Khanna',
            party:     'Democratic Party',
            photo_url: 'https://khanna.house.gov/photo.jpg',
            address:   [
              OpenStruct.new(
                line1: '306 Cannon House Office Building',
                city:  'Washington',
                state: 'DC',
                zip:   '20515'
              )
            ]
          )
        ],
        offices:   [
          OpenStruct.new(
            division_id:      'ocd-division/country:us/state:ca/cd:17',
            name:             'U.S. Representative',
            official_indices: [0]
          )
        ]
      )
    end

    before do
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(civic_info_service)
      allow(civic_info_service).to receive(:representative_info_by_address).and_return(api_response)
    end

    context 'when the representative does not exist' do
      before do
        described_class.civic_api_to_representative_params(api_response)
      end

      it 'creates a new representative' do
        expect(described_class.count).to eq(1)
      end

      it 'sets the correct name for the new representative' do
        expect(described_class.last.name).to eq('Ro Khanna')
      end

      it 'sets the correct political party for the new representative' do
        expect(described_class.last.political_party).to eq('Democratic Party')
      end

      it 'sets the correct photo URL for the new representative' do
        expect(described_class.last.photo_url).to eq('https://khanna.house.gov/photo.jpg')
      end

      it 'sets the correct address street for the new representative' do
        expect(described_class.last.address_street).to eq('306 Cannon House Office Building')
      end

      it 'sets the correct city for the new representative' do
        expect(described_class.last.address_city).to eq('Washington')
      end

      it 'sets the correct state for the new representative' do
        expect(described_class.last.address_state).to eq('DC')
      end

      it 'sets the correct zip for the new representative' do
        expect(described_class.last.address_zip).to eq('20515')
      end

      it 'sets the correct OCD ID for the new representative' do
        expect(described_class.last.ocdid).to eq('ocd-division/country:us/state:ca/cd:17')
      end

      it 'sets the correct title for the new representative' do
        expect(described_class.last.title).to eq('U.S. Representative')
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

      before do
        described_class.civic_api_to_representative_params(api_response)
        existing_rep.reload
      end

      it 'does not create a new representative' do
        expect(described_class.count).to eq(1)
      end

      it 'updates the political party of the existing representative' do
        expect(existing_rep.political_party).to eq('Democratic Party')
      end

      it 'updates the photo URL of the existing representative' do
        expect(existing_rep.photo_url).to eq('https://khanna.house.gov/photo.jpg')
      end

      it 'keeps the existing address street of the representative' do
        expect(existing_rep.address_street).to eq('306 Cannon House Office Building')
      end

      it 'keeps the existing city of the representative' do
        expect(existing_rep.address_city).to eq('Washington')
      end

      it 'keeps the existing state of the representative' do
        expect(existing_rep.address_state).to eq('DC')
      end

      it 'keeps the existing zip of the representative' do
        expect(existing_rep.address_zip).to eq('20515')
      end

      it 'keeps the existing OCD ID of the representative' do
        expect(existing_rep.ocdid).to eq('ocd-division/country:us/state:ca/cd:17')
      end

      it 'keeps the existing title of the representative' do
        expect(existing_rep.title).to eq('U.S. Representative')
      end
    end
  end
end
