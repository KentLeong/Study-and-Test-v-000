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

  get '/signout' do
    if !!session[:user_id]
      session.destroy
      redirect to '/login'
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
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

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      user = User.create(username: params[:username], password: params[:password])
      user.save
      session[:user_id] = user.id

      redirect to '/tests'
    end
  end
end
