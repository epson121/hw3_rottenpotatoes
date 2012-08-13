# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @movie = Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.page.body
  pos1 = page.body.index(e1)
  pos2 = page.body.index(e2)
  assert_operator pos2, :>, pos1
end

Then /I should see all of the movies/ do 
  rows = Movie.count
  if rows.respond_to? :should
    rows.should == 10
  else
    assert_equal 10, rows
  end
end

Then /I should see no movies/ do
  @movie = Movie.all
  @movie.each do |m|
    Then %Q{I should not see "m.title"}
  end
end
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating = rating_list.split(", ")
  if uncheck == "check"
    rating.each do |value|
      When %Q{I #{uncheck}check "ratings[#{value}]"}
    end  
  else
    rating.each do |value|
      When %Q{I #{uncheck}check "ratings[#{value}]"}
    end
  end
end


