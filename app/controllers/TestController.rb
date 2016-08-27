class TestController < ApplicationController
  get '/tests' do
    @tests = Test.all
    erb :'/tests/show'
  end

  get '/tests/create' do
    erb :'/tests/create'
  end

  post '/tests' do
    Test.create(name: params[:name], description: params[:description], user_id: session[:user_id])
    redirect to '/tests'
  end
end
