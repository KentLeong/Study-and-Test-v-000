class TestController < ApplicationController
  get '/tests' do
    user_logged_in?
    @tests = Test.all
    erb :'/tests/show_all'
  end

  get '/tests/create' do
    user_logged_in?
    erb :'/tests/create'
  end

  get '/tests/:id' do
    user_logged_in?
    @test = Test.find_by_id(params[:id])
    @user = User.find_by_id(@test.user_id)
    erb :'/tests/show'
  end

  get '/tests/:id/edit' do
    user_logged_in?
    @test = Test.find_by_id(params[:id])
    @questions = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @questions << q
      end
    end
    erb :'/tests/edit'
  end

  get '/tests/:id/create_questions' do
    @test = Test.find_by_id(params[:id])
    @questions = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @questions << q
      end
    end
    erb :'/tests/create_questions'
  end

  post '/test/:id/submit' do
    @test = Test.find_by_id(params[:id])
    @questions = []
    @correct = []
    @incorrect = []
    Question.all.each do |q|
      if q.test_id == @test.id
        @questions << q
      end
    end



    @questions.each_with_index do |q, index|
      if q.answer == params[:questions].first["question#{index}"].first[:answer]
        @correct << params[:questions].first["question#{index}"].first[:q_num]
      else
        @incorrect << params[:questions].first["question#{index}"].first[:q_num]
      end
    end
    erb :'/tests/submit'
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
      Question.create(test_id: @test.id)
    end
    redirect to "/tests/#{@test.id}/create_questions"
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

  patch '/tests/:id/questions' do

    @user = User.find_by_id(session[:user_id])
    @test = Test.find_by_id(params[:id])

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
