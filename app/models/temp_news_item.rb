# frozen_string_literal: true

class TempNewsItem < ApplicationRecord
  def self.copy_news_list(news_list)
    news_list.each_with_index do |item, index|
      temp_news_params = {
        title:             item.title,
        link:              item.link,
        description:       item.description,
        representative_id: item.representative_id,
        news_list_index:   index,
        issue:             item.issue
      }
      TempNewsItem.create(temp_news_params)
    end
  end

  def self.destroy_all
    TempNewsItem.all.find_each(&:destroy)
  end
end
