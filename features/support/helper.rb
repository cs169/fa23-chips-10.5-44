# frozen_string_literal: true

module Clickables
  def click_on_county(county)
    find("[data-county-name='#{county}']", wait: 30, visible: false).click
  end
end

World(Clickables)
