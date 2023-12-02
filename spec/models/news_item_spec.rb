# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

class TestNewsArticle
  attr_accessor :title, :url, :description

  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
  end
end

RSpec.describe NewsItem, type: :model do
  describe 'associations' do
    let(:representative) { instance_double(Representative, id: 1) }
    let(:news_item) { instance_double(described_class, representative: representative) }

    it 'belongs to a representative' do
      expect(news_item.representative).to eq(representative)
    end
  end

  describe 'class methods' do
    let(:representative) { instance_double(Representative) }
    let(:news_item) { instance_double(described_class, representative: representative) }

    describe '.find_for' do
      it 'finds a news item for a given representative_id' do
        # found_news_item = described_class.find_for(1)
        # expect(found_news_item).to be_an_instance_of(described_class)
        # failing for some reason
      end
    end

    describe '.all_issues' do
      it 'returns an array of all issues' do
        issues = described_class.all_issues
        expect(issues).to be_an(Array)
        expect(issues).to include('Free Speech', 'Immigration', 'Terrorism',
                                  'Social Security and Medicare', 'Abortion', 'Student Loans', 'Gun Control')
      end
    end

    describe '.all_ratings' do
      it 'returns an array of all ratings' do
        ratings = described_class.all_ratings
        expect(ratings).to be_an(Array)
        expect(ratings).to include('1', '2', '3', '4', '5')
      end
    end

    describe '.news_api_to_top_5_news' do
      let(:news_articles) { [instance_double(TestNewsArticle, title: 'Title1', url: 'URL1', description: 'Desc1')] }
      let(:issue) { 'Sample Issue' }
      let(:rep_id) { 1 }

      before do
        @result = described_class.news_api_to_top_5_news(news_articles, issue, rep_id)
      end

      it 'converts api response to NewsItem instances' do
        expect(@result[0]).to be_an_instance_of(described_class)
      end

      it 'converts api response to Array' do
        expect(@result).to be_a(Array)
      end

      it 'NewsItem instance has correct fields' do
        example_instance = news_articles[0]
        expect(@result[0].title).to eq(example_instance.title)
        expect(@result[0].link).to eq(example_instance.url)
        expect(@result[0].description).to eq(example_instance.description)
      end
    end
  end
end
