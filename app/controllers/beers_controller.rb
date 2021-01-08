class BeersController < ApplicationController



  get '/beers/new' do
    erb :'beers/new'
  end

  post '/beers' do
    
  end  
end