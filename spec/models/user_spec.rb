# frozen_string_literal: true

require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  # Validation Tests
  describe 'validations' do
    subject do
      described_class.new(uid: 'uid123abc', provider: 'google_oauth2', first_name: 'Test', last_name: 'User',
                          email: 'test@example.com')
    end

    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  # Instance Method Tests
  describe '#name' do
    it 'returns the full name of the user' do
      user = described_class.new(first_name: 'Test', last_name: 'User')
      expect(user.name).to eq('Test User')
    end
  end

  describe '#auth_provider' do
    it 'returns the name of the provider' do
      user_google = described_class.new(provider: 'google_oauth2')
      user_github = described_class.new(provider: 'github')
      expect(user_google.auth_provider).to eq('Google')
      expect(user_github.auth_provider).to eq('Github')
    end
  end

  # Class Method Tests
  describe '.find_google_user' do
    it 'finds a user with Google OAuth2 provider' do
      user_google = described_class.create(uid: '123', provider: 'google_oauth2', first_name: 'Test', last_name: 'User',
                                           email: 'test@example.com')
      expect(described_class.find_google_user('123')).to eq(user_google)
    end
  end
end
