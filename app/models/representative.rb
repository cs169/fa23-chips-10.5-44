# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp, title_temp = find_ocdid_and_title(rep_info, index)

      rep = Representative.find_by(name: official.name)
      rep_params = parse_civic_api_response(official, ocdid_temp, title_temp)
      if rep.nil?
        rep = Representative.create!(rep_params)
      else
        rep.update(rep_params)
      end
      reps.push(rep)
    end
    reps
  end

  def self.find_ocdid_and_title(rep_info, index)
    rep_info.offices.each do |office|
      return [office.division_id, office.name] if office.official_indices.include? index
    end
    ['', '']
  end

  def self.parse_civic_api_response(official, ocdid_temp, title_temp)
    rep_params = {
      name:            official.name,
      political_party: official.party,
      photo_url:       official.photo_url || '',
      address_street:  '',
      address_city:    '',
      address_state:   '',
      address_zip:     '',
      ocdid:           ocdid_temp,
      title:           title_temp
    }
    if official.address
      rep_params[:address_street] = official.address[0].line1 || ''
      rep_params[:address_city] = official.address[0].city || ''
      rep_params[:address_state] = official.address[0].state || ''
      rep_params[:address_zip] = official.address[0].zip || ''
    end
    rep_params
  end
end
