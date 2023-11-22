# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      rep_params = parse_civic_api_response(official)
      rep_params[:ocdid] = ocdid_temp
      rep_params[:title] = title_temp
      rep = Representative.create!(rep_params)
      reps.push(rep)
    end

    reps
  end

  def parse_civic_api_response(official)
    rep_params = {}
    rep_params[:name] = official.name
    rep_params[:address_street] = official.address.line1 || ''
    rep_params[:address_city] = official.address.city || ''
    rep_params[:address_state] = official.address.state || ''
    rep_params[:address_zip] = official.address.zip || ''
    rep_params[:political_party] = official.party || ''
    rep_params[:photo_url] = official.photoUrl || ''
    rep_params
  end
end
