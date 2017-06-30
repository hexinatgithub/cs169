require "rails_helper"

describe Movie do
  describe "given a movie" do
    context "find the same director movies," do
      it "should return only the given movie" do
        match_movie = double("Movie_1", director: 'George Lucas')
        fake_results = [match_movie]
        expect(Movie).to receive(:where).with(director: 'George Lucas').
          and_return(fake_results)
        expect(Movie.find_same_director match_movie).to eq fake_results
      end
      
      it "should return the match movies" do
        match_movie = double("Movie_1", director: 'George Lucas')
        fake_results = [match_movie, double("Movie_2", director: 'George Lucas'), 
                          double("Movie_3", director: 'George Lucas')]
        expect(Movie).to receive(:where).with(director: 'George Lucas').
          and_return(fake_results)
        expect(Movie.find_same_director match_movie).to eq fake_results
      end
    end
  end
end