# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.all_issues
    ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
     'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
     'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality',
     'Religious Freedom', 'Border Security', 'Minimum Wage',
     'Equal Pay']
  end

  def self.all_ratings
    %w[1 2 3 4 5]
  end

  def self.news_api_to_top_5_news(news_articles, issue, rep_id)
    news = []
    news_articles.each do |article|
      article_params = {
        title:             article.title,
        link:              article.url,
        description:       article.description,
        issue:             issue,
        representative_id: rep_id
      }
      curr_article = NewsItem.new(article_params)
      news.push(curr_article)
    end
    news
  end
end
