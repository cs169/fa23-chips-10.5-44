# frozen_string_literal: true

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

Given(/^I am on the "(.*)" in the map$/) do |state|
  visit "/state/#{state}"
end

When(/^I click on "(.*)" in the map$/) do |county|
  click_on_county(county)
end

Then(/^I should see representatives for "(.*)"$/) do |county|
  expect(page).to have_content(representatives_for(county))
end
