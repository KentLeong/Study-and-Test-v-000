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
    if !session[:user_id]
      redirect to '/'
    end
    erb :'/tests/show'
  end

  get '/tests/:id/edit' do
    @test = Test.find_by_id(params[:id])
    @multiple_choices = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @multiple_choices << q
      end
    end
    erb :'/tests/edit'
  end

  delete '/tests/:id/delete' do
    @test = Test.find_by_id(params[:id])
    if session[:user_id] == @test.user_id
      if @test.user_id == session[:user_id]
        @test.delete
        redirect to '/tests'
      else
        redirect to '/tests'
      end
    else
      redirect to '/tests'
    end
  end

  patch '/tests/:id' do
    @user = User.find_by_id(session[:user_id])
    @test = Test.find_by_id(params[:id])
    @test.name = params[:name]
    @test.description = params[:description]
    @test.save
    redirect to "/tests/#{@test.id}"
  end
end
