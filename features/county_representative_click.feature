Feature: County Representative Display
  As a user of the map
  I want to be able to click on counties
  So that I can see the representatives for each county

  Scenario: User clicks on a Counties in California
    Given I am on the "CA" in the map
    When I click on "Counties in California" in the map
    Then the table should expand
  
  Scenario: Checking County Representatives
    Given I am on the representatives page for "Orange County" in "CA"
    Then I can see the representatives table