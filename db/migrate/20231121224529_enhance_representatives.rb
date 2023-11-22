# frozen_string_literal: true

class EnhanceRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address_street, :string
    add_column :representatives, :address_city, :string
    add_column :representatives, :address_state, :string
    add_column :representatives, :address_zip, :string
    add_column :representatives, :political_party, :string
    add_column :representatives, :photo_url, :string
  end
end
