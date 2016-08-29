class TestController < ApplicationController
  get '/tests' do
    @tests = Test.all
    erb :'/tests/show_all'
  end

  get '/tests/create' do
    erb :'/tests/create'
  end

  post '/tests/:id/test' do
    @test = Test.find_by_id(params[:id])
    @questions = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @questions << q
      end
    end
    erb :'/tests/take'
  end

  post '/tests/question' do
    @test = Test.create(name: params[:name], description: params[:description], user_id: session[:user_id])
    count = params[:questions].to_i
    count.times do
      @questions = Question.create(test_id: @test.id)
    end
    erb :'/tests/create_questions'
  end

  get '/tests/:id' do
    @test = Test.find_by_id(params[:id])
    @user = User.find_by_id(@test.user_id)
    if !session[:user_id]
      redirect to '/'
    end
    erb :'/tests/show'
  end

  get '/tests/:id/edit' do
    @test = Test.find_by_id(params[:id])
    @questions = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @questions << q
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

    @question_count = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @question_count << q
      end
    end

    @count = @question_count.count
    @questions = params[:questions].first
    s = 0

    while s < @count do
      @question = Question.find_by_id(@questions["question#{s}"].first[:q_id])
      @question.question = @questions["question#{s}"].first[:question]
      @question.choice1 = @questions["question#{s}"].first[:choice1]
      @question.choice2 = @questions["question#{s}"].first[:choice2]
      @question.choice3 = @questions["question#{s}"].first[:choice3]
      @question.choice4 = @questions["question#{s}"].first[:choice4]
      @question.answer = @questions["question#{s}"].first[:answer]
      @question.save
      s += 1
    end

    redirect to "/tests/#{@test.id}"
  end
end
