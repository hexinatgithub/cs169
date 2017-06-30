Rottenpotatoes::Application.routes.draw do
  get 'movies/same_director_movies/:id', to: 'movies#same_director_movies'
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
