# frozen_string_literal: true

class CreateTempNewsItems < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_news_items do |t|
      t.string 'title', null: false
      t.string 'link', null: false
      t.text 'description'
      t.integer 'representative_id', null: false
      t.integer 'news_list_index', null: false
      t.string 'issue'
      t.timestamps
    end
  end
end
