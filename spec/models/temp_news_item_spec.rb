# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TempNewsItem, type: :model do
  describe '.copy_news_list' do
    before do
      @news_list = [
        instance_double(NewsItem, title: 'Title1', link: 'URL1', description: 'Desc1', representative_id: 1,
issue: 'Issue1'),
        instance_double(NewsItem, title: 'Title2', link: 'URL2', description: 'Desc2', representative_id: 2,
issue: 'Issue2')
      ]
    end

    it 'copies news list to temporary items' do
      expect do
        described_class.copy_news_list(@news_list)
      end.to change(described_class, :count).by(2)
    end

    it 'copies attributes correctly' do
      described_class.copy_news_list(@news_list)
      expect(described_class.first.title).to eq('Title1')
      expect(described_class.first.link).to eq('URL1')
      expect(described_class.first.description).to eq('Desc1')
      expect(described_class.first.issue).to eq('Issue1')
    end
  end

  describe '.destroy_all' do
    it 'destroys all temporary items' do
      described_class.create(title: 'TempTitle', link: 'TempURL', description: 'TempDesc', representative_id: 1,
                             issue: 'TempIssue', news_list_index: 1)

      expect { described_class.destroy_all }.to change(described_class, :count).by(-1)
    end
  end
end
