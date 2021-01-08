class BeersController < ApplicationController


  
  get '/beers/new' do
    erb :'beers/new'
  end
end