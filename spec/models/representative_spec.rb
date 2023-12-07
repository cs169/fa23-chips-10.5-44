# frozen_string_literal: true

require 'google/apis/civicinfo_v2'
require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      double('RepInfo',
             officials: [official],
             offices:   [office])
    end
    let(:official) do
      double('Official',
             name:      'Ro Khanna',
             party:     'Democratic Party',
             photo_url: 'https://khanna.house.gov/sites/khanna.house.gov/files/styles/congress_image_thumbnail/public/featured_image/RepRoKhanna_CA17_hires.jpg?itok=Rb-0G6Ky',
             address:   [address])
    end
    let(:address) do
      double('Address',
             line1: '306 Cannon House Office Building',
             city:  'Washington',
             state: 'DC',
             zip:   '20515')
    end
    let(:office) do
      double('Office',
             division_id:      'ocd-division/country:us/state:ca/cd:17',
             name:             'U.S. Representative',
             official_indices: [0])
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        expect { described_class.civic_api_to_representative_params(rep_info) }.to change(described_class, :count).by(1)
        rep = described_class.last
        expect(rep.name).to eq('Ro Khanna')
        expect(rep.political_party).to eq('Democratic Party')
        expect(rep.photo_url).to eq('https://khanna.house.gov/sites/khanna.house.gov/files/styles/congress_image_thumbnail/public/featured_image/RepRoKhanna_CA17_hires.jpg?itok=Rb-0G6Ky')
        expect(rep.address_street).to eq('306 Cannon House Office Building')
        expect(rep.address_city).to eq('Washington')
        expect(rep.address_state).to eq('DC')
        expect(rep.address_zip).to eq('20515')
        expect(rep.ocdid).to eq('ocd-division/country:us/state:ca/cd:17')
        expect(rep.title).to eq('U.S. Representative')
      end
    end

    context 'when the representative already exists' do
      before do
        described_class.create!(name: 'Ro Khanna', ocdid: 'ocd-division/country:us/state:ca/cd:17',
                                title: 'U.S. Representative')
      end

      it 'does not create a new representative' do
        expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
      end

      it 'updates the existing representative' do
        described_class.civic_api_to_representative_params(rep_info)
        rep = described_class.find_by(name: 'Ro Khanna')
        expect(rep.political_party).to eq('Democratic Party')
        expect(rep.photo_url).to eq('https://khanna.house.gov/sites/khanna.house.gov/files/styles/congress_image_thumbnail/public/featured_image/RepRoKhanna_CA17_hires.jpg?itok=Rb-0G6Ky')
        expect(rep.address_street).to eq('306 Cannon House Office Building')
        expect(rep.address_city).to eq('Washington')
        expect(rep.address_state).to eq('DC')
        expect(rep.address_zip).to eq('20515')
        # Ensure other fields like ocdid and title remain unchanged.
      end
    end
  end
end
