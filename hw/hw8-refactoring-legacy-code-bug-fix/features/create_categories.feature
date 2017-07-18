Feature: Create or Edit Category
  As an admin
  I want to category my blogs
  
  Background: login as a admin
    Given the blog is set up
    And I am logged into the admin panel
    When I am on the category edit page
    And I fill in "category_name" with "category1"
    And I fill in "category_keywords" with "test1"
    And I fill in "category_permalink" with "general1"
    And I fill in "category_description" with "testCreate"
    And I press "Save"
    
  Scenario: Success create a new category
    When I am on the category edit page
    Then I should see "category1"
    And I should see "category1"
    And I should see "test1"
    And I should see "general1"
    And I should see "testCreate"
    
  Scenario: Success edit a category
    When I am on the category new page
    And I follow "category1"
    And I fill in "category_name" with "category2"
    And I fill in "category_keywords" with "test2"
    And I fill in "category_permalink" with "general2"
    And I fill in "category_description" with "testEdit"
    And I press "Save"
    Then I should be on the category edit page
    Then I should see "category2"
    And I should see "test2"
    And I should see "general2"
    And I should see "testEdit"
    And I should not see "category1"