class BeersController < ApplicationController

  get '/beers' do
    @beers = Beer.all
    @beer = Beer.find_by_id(session[:beer_id])
    erb :'beers/index'
  end

  
  get '/beers/new' do
    erb :'beers/new'
  end

  get '/beers/:id' do
    find_beer
    session[:beer_id] = @beer.id if @beer
    redirect_if_beer_not_found
    erb :'beers/show'
  end
  
  get '/beers/:id/edit' do
    find_beer
    redirect_if_beer_not_found
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
    redirect_if_beer_not_found
    if @beer.update(params[:beer])
      redirect "/beers/#{@beer.id}"
    else
      redirect "/beers/#{@beer.id}/edit"
    end
  end

  delete '/beers/:id' do
    find_beer
    @beer.destroy if @beer
    redirect "/beers"
  end
  
  private
  def find_beer
    @beer = Beer.find_by_id(params[:id])
  end
  
  def redirect_if_beer_not_found
    redirect "/beers" unless @beer
  end
  
end