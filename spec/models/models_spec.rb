require 'spec_helper'

describe 'Models' do

  describe 'User' do
    before do
      @user = User.create(:username => "test", :password => "test")
    end

    it 'has a secure password' do
      expect(@user.authenticate("dog")).to eq(false)
      expect(@user.authenticate("test")).to eq(@user)
    end
  end

  describe 'Study' do
    before do
      @study = Study.create(:name => "test")
    end

    it 'has a name' do
      expect(@study.name).to eq("test")
    end
  end

  describe 'Test' do
    before do
      @test = Test.create(:name => "test")
    end

    it 'has a name' do
      expect(@test.name).to eq("test")
    end
  end
end
