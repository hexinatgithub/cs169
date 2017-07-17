Feature: Merge Article
  As a authors
  If I have mutli article with the same topic
  I want to merge these article into one
  
  Background: given some article
    Given the blog is set up
    And I am logged into the admin panel
    Given I have a article with title "Foobar1" and body "Body1"
    And I have a article with title "Foobar2" and body "Body2"
  
  Scenario: success merge article
    When I merge "Foobar1" article with "Foobar2" article
    Then I should be on the admin content page
    Then I should see the article with title "Foobar1" and body "Body1" and body "Body2"
    
  Scenario: success merge article comments
    When I add comment "test1 comment" to "Foobar1" article with author "test1" and email "test1@example.com"
    And I add comment "test2 comment" to "Foobar2" article with author "test2" and email "test2@example.com"
    And I merge "Foobar1" article with "Foobar2" article
    When I on the "Foobar1" article content page
    Then I should see the article with title "Foobar1" and body "Body1" and body "Body2"
    Then I should see "test1 comment"
    And I should see "test2 comment"