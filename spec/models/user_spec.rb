require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @attr = {:name => "Example User", :email => "user@example.com"}
  end
  it "should create a new instance given valid attributes" do
    user = User.create!(@attr)
  end
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
   it "should require an email adress" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_usr = User.new(@attr.merge(:name=>long_name))
    long_name_usr.should_not be_valid
  end
  
  
  it "should accept valid email addresses" do
   addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
   addresses.each do | address |
      user = User.new (@attr.merge(:email=>address))
      user.should be_valid
   end 
  end
  
  it "should reject invalid email adresses" do
   addresses = %w[user@foo,com user_at_foo.bar.org first.last@foo.]
   addresses.each do | address |
      user = User.new (@attr.merge(:email=>address))
      user.should_not be_valid
   end 
  end
  
  it "should reject duplicate email adresses" do
    User.create!(@attr)
    user = User.new(@attr)
    user.should_not be_valid
  end
 
  it "should reject email adresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email=>upcased_email))
    user = User.new(@attr)
    user.should_not be_valid
  end
  
end
