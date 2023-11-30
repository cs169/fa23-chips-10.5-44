# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_news_item, only: %i[edit update destroy]

  # renders the select representative + issue search view
  def new
    @news_item = NewsItem.new
  end

  def edit; end

  # renders the select news article view to add to database
  def select_news
    @issue = params[:news_item][:issue]
    news_service = News.new(Rails.application.credentials[:GOOGLE_NEWS_API_KEY])
    result = news_service.get_everything(q: "#{@issue} AND #{@representative.name}", language: 'en',
                                         sortBy: 'relevancy', pageSize: 5)
    @news_list = NewsItem.news_api_to_top_5_news(result, @issue, @representative.id)
    TempNewsItem.copy_news_list(@news_list)
    render :select_form
  end

  def create
    selected_news_index = params[:selected_news_index].to_i
    temp_news_item = TempNewsItem.find_by(news_list_index: selected_news_index)
    temp_news_items_params = {
      title:             temp_news_item.title,
      link:              temp_news_item.link,
      description:       temp_news_item.description,
      representative_id: temp_news_item.representative_id,
      issue:             temp_news_item.issue
    }
    @news_item = NewsItem.new(temp_news_items_params)
    Rails.logger.debug @news_item
    if @news_item.save
      TempNewsItem.destroy_all
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_issues_list
    @issues_list = NewsItem.all_issues
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
