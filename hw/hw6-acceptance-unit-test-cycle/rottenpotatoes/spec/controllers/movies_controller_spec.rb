require "rails_helper"

describe MoviesController do
  describe "given a movie id, find the similar movies," do
    context "the movie id is invalid" do
      it "should redirect to movies_path" do
        expect(Movie).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :same_director_movies, id:1
        expect(flash[:warning]).to eq nil
        expect(response).to redirect_to(movies_path)
      end
    end
    
    context "the movie info has a director" do
      before :each do
        match_movie = double("Movie_1", title: 'Star Wars1', director: 'George Lucas')
        expect(Movie).to receive(:find).with("1").and_return(match_movie)
        @fake_results = [match_movie, double("Movie_2", title: 'Star Wars2', director: 'George Lucas')]
        expect(Movie).to receive(:find_same_director).with(match_movie).
          and_return(@fake_results)
      end
      
      it "should call Movie to match similar movies" do
        get :same_director_movies, id:1
        expect(assigns(:movies)).to match_array(@fake_results)
      end
    end
    
    context "the movie info has no director" do
      before :each do
        @match_movie = double("Movie_1", title: 'Star Wars', director: '')
        expect(Movie).to receive(:find).with("1").and_return(@match_movie)
        get :same_director_movies, id:1
      end
      
      it "should redirect to movies_path and with a warning" do
        expect(flash[:warning]).to eq "'#{@match_movie.title}' has no director info"
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end