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
end
