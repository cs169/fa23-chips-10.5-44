Feature: Create a Representative
  representative profile page

Scenario: Show the representative view 
  Given I create the following representative:
    | name          | title       | ocdid       | address_street | address_city | address_state | address_zip | political_party | photo_url              |
    | mock_name     | mock_title  | mock_ocdid  | mock_street    | mock_city    | mock_state    | mock_zip    | mock_party      | mock_photo_url.png     |
  #When I am on "mock_name" in the profile page
  #And I should see the representative's photo with src "mock_photo_url.png"
  #And I should see "mock_name"
  #And I should see "mock_title"
 # And I should see "mock_ocdid"
  #And I should see "mock_line1"
  #And I should see "mock_city"
 # And I should see "mock_state"
 # And I should see "mock_zip"
 # And I should see "mock_party"

 #the and stuff may not be right but you get the idea...