class UserController < ApplicationController
  get '/login' do
    erb :'/users/login'
  end

  get '/user/:id' do
    erb :'/users/show'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tests'
    else
      redirect '/login'
    end
  end
end
