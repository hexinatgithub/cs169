Feature: User can add movie by searching for it in The Movie Database (TMDb)
 
  As a movie fan
  So that I can add new movies without manual tedium
  I want to add movies by looking up their details in TMDb
 
Background: Start from the Search form on the home page
 
  Given I am on the RottenPotatoes home page
  Then I should see "Search TMDb for a movie"
 
Scenario: Try to add nonexistent movie (sad path)
 
  When I fill in "Search Terms" with "Movie That Does Not Exist"
  And I press "Search TMDb"
  Then I should be on the RottenPotatoes home page
  And I should see "'Movie That Does Not Exist' was not found in TMDb."
 
Scenario: Try to add existing movie (happy path)
 
  When I fill in "Search Terms" with "Inception"
  And I press "Search TMDb"
  Then I should be on the "Search Results" page
  And I should not see "not found"
  And I should see "Inception"
  
Feature: movies should appear in alphabetical order, not added order
 
Scenario: view movie list after adding movie (declarative and DRY)
 
  Given I have added "Zorro" with rating "PG-13"
  And   I have added "Apocalypse Now" with rating "R"
  And   I am on the RottenPotatoes home page sorted by title
  Then  I should see "Apocalypse Now" before "Zorro"