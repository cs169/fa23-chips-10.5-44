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
# Given(/^I am on the representative page for "(.*)"$/)
#   visit "/search/"
# end
