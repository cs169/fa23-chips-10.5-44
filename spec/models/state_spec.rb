# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  # Association test
  it { is_expected.to have_many(:counties).inverse_of(:state).dependent(:delete_all) }

  # Method tests
  describe '#std_fips_code for states' do
    it 'returns the standardized FIPS code for states' do
      state = described_class.new(fips_code: 6)
      expect(state.std_fips_code).to eq('06')
    end
  end
end
