# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  # Association test
  it { is_expected.to belong_to(:state) }

  # Method tests
  describe '#std_fips_code' do
    it 'returns the standardized FIPS code' do
      county = described_class.new(fips_code: 1)
      expect(county.std_fips_code).to eq('001')
    end
  end
end
