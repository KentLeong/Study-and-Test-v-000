class TestController < ApplicationController
  get '/tests' do
    @tests = Test.all
    erb :'/tests/show_all'
  end

  get '/tests/create' do
    erb :'/tests/create'
  end

  post '/tests' do
    Test.create(name: params[:name], description: params[:description], user_id: session[:user_id])
    redirect to '/tests'
  end

  get '/tests/:id' do
    @user = User.find_by_id(session[:user_id])
    @test = Test.find_by_id(params[:id])
    erb :'/tests/show'
  end
end
