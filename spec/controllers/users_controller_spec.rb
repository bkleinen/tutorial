require 'spec_helper'

describe UsersController do
  render_views
  
  before :each do
    @factory_user = Factory(:user)
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
  
  describe "GET 'show'" do

    it "should find the right user" do
      get :show, :id => @factory_user
      assigns(:user).should == @factory_user
    end

    it "should have the right title" do
      get :show, :id => @factory_user
      response.should have_selector("title", :content => @factory_user.name)
    end

    it "should include the user's name" do
      get :show, :id => @factory_user
    end

    it "should have a profile image" do
      get :show, :id => @factory_user
      response.should have_selector("h1>img", :class => "gravatar")
    end  
    
  end
  
  
end
