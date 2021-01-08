class BeersController < ApplicationController

  get '/beers' do
    @beers = Beer.all
    erb :'beers/index'
  end

  
  get '/beers/new' do
    erb :'beers/new'
  end
  
  get '/beers/:id' do
    @beer = Beer.find_by_id(params[:id])
    erb :'beers/show'
  end
  
  post '/beers' do
    beer = Beer.new(params[:beer])
    
    if beer.save
      redirect '/beers'
    else
      redirect '/beers/new'
    end
  end  
end