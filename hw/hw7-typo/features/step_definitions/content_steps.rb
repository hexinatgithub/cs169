Given /I have a article with title "(.*)" and body "(.*)"/ do |title, body|
  steps %Q{
    When I go to the new article page
    And I fill in "article_title" with "#{title}"
    And I fill in "article__body_and_extended_editor" with "#{body}"
    And I press "Publish"
  }
end

When /I on the "(.*)" article admin content page/ do |title|
  steps %Q{
    When I go to the admin content page
    When I follow "#{title}"
  }
end

When /I on the "(.*)" article content page/ do |title|
  steps %Q{
    When I go to the home page
    When I follow "#{title}"
  }
end

When /I change the "(.*)" article with body "(.*)"/ do |title, body|
  steps %Q{
    When I on the "#{title}" article admin content page
    And I fill in "article__body_and_extended_editor" with "#{body}"
    And I press "Publish"
  }
end

Then /I should see the article with title "(.*)" and body "(.*)" and body "(.*)"/ do |title, body1, body2|
  steps %Q{
    When I go to the home page
    Then I should see "#{title}"
    When I follow "#{title}"
    Then I should see "#{body1}"
    Then I should see "#{body2}"
  }
end

When /I merge "(.*)" article with "(.*)" article/ do |title1, title2|
  id = Article.find_by_title(title1).id
  other_id = Article.find_by_title(title2).id
  steps %Q{
    When I on the "#{title1}" article admin content page
    And I fill in "merge_with" with "#{other_id}"
    And I press "Merge"
  }
end

When /I add comment "(.*)" to "(.*)" article with author "(.*)" and email "(.*)"/ do |comment, title, author, email|
  steps %Q{
    When I go to the home page
    Then I should see "#{title}"
    When I follow "#{title}"
    And I fill in "comment_author" with "#{author}"
    And I fill in "comment_email" with "#{email}"
    And I fill in "comment_body" with "#{comment}"
    And I press "comment"
  }
end