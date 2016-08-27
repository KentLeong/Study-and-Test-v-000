class TestController < ApplicationController
  get '/tests' do
    @tests = Test.all
    erb :'/tests/show'
  end
end
