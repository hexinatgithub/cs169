Feature: Edit Article
  As an author
  I order to improve my thought to world
  I want to edit my article
  
  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And I have a article with title "Foobar" and body "Game of throne comming!"
  
  Scenario: Successfully edit my article
    When I change the "Foobar" article with body "Nice movie"
    Then I should be on the admin content page
    When I on the "Foobar" article content page
    Then I should see "Nice movie"