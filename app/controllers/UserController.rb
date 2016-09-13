class UserController < ApplicationController
  get '/login' do
    redirect to "/tests" if logged_in?
    erb :'/users/login'
  end

  get '/signup' do
    redirect to "/tests" if logged_in?
    erb :'/users/signup'
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      erb :'/users/show'
    else
      redirect to "/login"
    end
  end

  get '/signout' do
    session.destroy if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tests'
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    if User.find_by_username(params[:username]) == nil && params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      user = User.create(username: params[:username], password: params[:password])
      user.save
      session[:user_id] = user.id
      redirect to '/tests'
    end
  end
end
