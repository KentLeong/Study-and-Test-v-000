class UserController < ApplicationController
  get '/login' do
    if logged_in?
      redirect to "/tests"
    else
      erb :'/users/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/tests"
    else
      erb :'/users/signup'
    end
  end

  get '/signout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      erb :'/users/show'
    else
      redirect to "/login"
    end
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
    if User.find_by_username(params[:username]) == nil
      if params[:username] == "" || params[:password] == ""
        redirect to "/signup"
      else
        user = User.create(username: params[:username], password: params[:password])
        user.save
        session[:user_id] = user.id

        redirect to '/tests'
      end
    else
      redirect to "/signup"
    end
  end
end
