class TestController < ApplicationController
  get '/tests' do
    if logged_in?
      @tests = Test.all
      erb :'/tests/show_all'
    else
      redirect to "/login"
    end
  end

  get '/tests/create' do
    if logged_in?
      erb :'/tests/create'
    else
      redirect to '/login'
    end
  end

  get '/tests/:id' do
    if logged_in?
      @test = Test.find_by_id(params[:id])
      @user = User.find_by_id(@test.user_id)
      erb :'/tests/show'
    else
      redirect to "/login"
    end
  end

  get '/tests/:id/edit' do
    @test = Test.find_by_id(params[:id])
    if current_user.id == @test.user_id
      get_questions
      erb :'/tests/edit'
    else
      redirect to '/login'
    end
  end

  get '/tests/:id/create_questions' do
    @test = Test.find_by_id(params[:id])
    if current_user.id == @test.user_id
      get_questions
      erb :'/tests/create_questions'
    else
      redirect to '/login'
    end
  end

  post '/test/:id/submit' do
    @test = Test.find_by_id(params[:id])
    @correct = []
    @incorrect = []
    get_questions

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
    get_questions
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
    @test.delete if current_user.id == @test.user_id && @test.user_id == session[:user_id]
    redirect to '/tests'
  end

  patch '/tests/:id/questions' do
    #Patch new questions
    @user = User.find_by_id(session[:user_id])
    @test = Test.find_by_id(params[:id])
    update_questions
    redirect to "/tests/#{@test.id}"
  end

  patch '/tests/:id' do
    #Patch edit questions
    @user = User.find_by_id(session[:user_id])
    @test = Test.find_by_id(params[:id])
    @test.update(name: params[:name], description: params[:description])
    update_questions
    redirect to "/tests/#{@test.id}"
  end

  private
    def get_questions
      @questions = []
      Question.all.each do |q|
        if q.test_id == @test.id
          @questions << q
        end
      end
    end

    def update_questions
      get_questions
      @count = @questions.count
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
    end
end
