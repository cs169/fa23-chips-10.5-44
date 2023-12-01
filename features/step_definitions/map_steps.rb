# frozen_string_literal: true

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

Given(/^I am on the "(.*)" in the map$/) do |state|
  visit "/state/#{state}"
end

When(/^I click on "(.*)" in the map$/) do |county|
  click_button county
end

Then(/^the table should expand$/) do
  expect(find('button[data-target="#actionmap-state-details-collapse"]')['aria-expanded']).to eq(nil)
end

Given(/^I am on the representatives page for "(.*)" in "(.*)"$/) do |county, state|
  encoded_location = CGI.escape("#{county}, #{state}")
  path = "/search/#{encoded_location}"
  visit path
end

Then(/^I can see the representatives table$/) do
  expect(page).to have_css('#events')
end
