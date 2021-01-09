class BeersController < ApplicationController

  get '/beers' do
    @beers = Beer.all
    erb :'beers/index'
  end

  
  get '/beers/new' do
    erb :'beers/new'
  end

  get '/beers/:id' do
    find_beer
    erb :'beers/show'
  end
  
  get '/beers/:id/edit' do
    find_beer
    erb :'beers/edit'
  end

  post '/beers' do
    beer = Beer.new(params[:beer])
    
    if beer.save
      redirect '/beers'
    else
      redirect '/beers/new'
    end
  end 

  patch "/beers/:id" do
    find_beer
    if @beer.update(params[:beer])
      redirect "/beers/#{@beer.id}"
    else
      redirect "/beers/#{@beer.id}/edit"
    end
  end
  
  private
    def find_beer
      @beer = Beer.find_by_id(params[:id])
    end

end