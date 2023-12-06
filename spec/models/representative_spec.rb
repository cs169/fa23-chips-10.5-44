# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      double("RepInfo", officials: [official], offices: [office])
    end
    let(:official) do
      double("Official", name: "John Doe", party: "Independent", photo_url: "http://example.com/photo.jpg", address: [address])
    end
    let(:address) do
      double("Address", line1: "123 Main St", city: "Anytown", state: "Anystate", zip: "12345")
    end
    let(:office) do
      double("Office", division_id: "ocdid-123", name: "Mayor", official_indices: [0])
    end

    context 'when the representative does not exist' do
      it 'creates a new representative' do
        expect { Representative.civic_api_to_representative_params(rep_info) }.to change(Representative, :count).by(1)
      end
    end

    context 'when the representative already exists' do
      before do
        Representative.create!(name: "John Doe", ocdid: "ocdid-123", title: "Mayor")
      end

      it 'does not create a new representative' do
        expect { Representative.civic_api_to_representative_params(rep_info) }.not_to change(Representative, :count)
      end

      it 'updates the existing representative' do
        Representative.civic_api_to_representative_params(rep_info)
        representative = Representative.find_by(name: "John Doe")
        expect(representative.political_party).to eq("Independent")
        expect(representative.photo_url).to eq("http://example.com/photo.jpg")
        expect(representative.address_street).to eq("123 Main St")
        # may need to add additional expectations for other attributes
      end
    end
  end
end