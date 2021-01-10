class BeersController < ApplicationController

  get '/beers' do
    redirect_if_not_logged_in
    @beers = current_user.beers
    @beer = Beer.find_by_id(session[:beer_id])
    erb :'beers/index'
  end

  
  get '/beers/new' do
    redirect_if_not_logged_in
    erb :'beers/new'
  end

  get '/beers/:id' do
    redirect_if_not_logged_in
    find_beer
    redirect_if_not_owner
    session[:beer_id] = @beer.id if @beer
    redirect_if_beer_not_found
    erb :'beers/show'
  end
  
  get '/beers/:id/edit' do
    redirect_if_not_logged_in
    find_beer
    redirect_if_beer_not_found
    redirect_if_not_owner
    erb :'beers/edit'
  end
  
  post '/beers' do
    beer = current_user.beers.build(params[:beer])
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
    redirect_if_beer_not_found
    redirect_if_not_owner
    @beer.destroy
    redirect "/beers"
  end
  
  private
  def find_beer
    @beer = Beer.find_by_id(params[:id])
  end
  
  def redirect_if_beer_not_found
    redirect "/beers" unless @beer
  end

  def redirect_if_not_owner
    redirect "/beers" unless @beer.user == current_user
  end
  
end