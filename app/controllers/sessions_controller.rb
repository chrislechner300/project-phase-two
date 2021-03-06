class SessionsController < ApplicationController
  get '/signup' do
    erb:'sessions/signup'
  end

  post '/signup' do
    redirect_if_logged_in
    user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect "/beers"
      else
        redirect "/signup"
    end
  end

  get '/login' do
    redirect_if_logged_in
    erb :'sessions/login'
  end

  post '/login' do
    user = User.find_by_username(params[:user][:username])
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect "/beers"
      else
        redirect "/login"
      end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end