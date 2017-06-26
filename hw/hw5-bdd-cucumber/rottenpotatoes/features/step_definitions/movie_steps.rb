# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie) if not Movie.find_by(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}.*/m
  expect(regexp.match(page.body)).not_to eq nil
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  check_or_not = uncheck ? "uncheck" : "check"
  rating_list.delete(' ').split(',').each do |rating|
    steps `When I #{check_or_not} "ratings_#{rating}"`
  end
end

Then /I should( not)? see following movies: (.*)/ do |should_see, movie_list|
  see_or_not = should_see ? " not" : ""
  movie_list.split(',').each do |movie|
    movie = movie.strip
    steps `Then I should#{see_or_not} see #{movie}`
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all(:xpath, "//tbody//tr").length
  movies = Movie.all
  expect(rows).to eq movies.length
  movies.each do |movie|
    steps `Then I should see "#{movie.title}"`
  end
end

Then /I should see movies sorted in (.*)/ do |order_item|
  movies = Movie.all
  order_item = order_item.delete '"'
  if order_item == "alphabetically"
    movies = movies.order :title
  elsif order_item == "release date"
    movies = movies.order :release_date
  end
  movies.each_index do |i|
    if i <= movies.length - 2
      movie_1 = movies[i]
      movie_2 = movies[i+1]
      steps `Then I should see "#{movie_1.title}" before "#{movie_2.title}"`
    end
  end
end