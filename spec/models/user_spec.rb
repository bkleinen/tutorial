require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @attr = {
      :name => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  # for copying into consoles:
  # a = {      :name => "Example User",      :email => "user@example.com",    :password => "foobar",    :password_confirmation => "foobar"   }
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
  
  describe "password validations" do 
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end

    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    it "should reject long passwords" do
      long = "a" *41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end    
    describe "password encryption" do
      before(:each) do
        @user = User.create!(@attr)
      end
      
      it "should have an ecrypted password attribute" do
        @user.should respond_to(:encrypted_password)
      end
      
      it "should set the encrypted password" do
       @user.encrypted_password.should_not be_blank
      end
      
      it "should be true if the passwords match" do
        @user.has_password?("foobar").should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
      
      describe "authenticate method" do
        it "should return nil on email/password mismatch" do
          user = User.authenticate(@attr[:email], "wrongpass")
          user.should be_nil
        end
        it "should return nil for an email address with no user" do
          user = User.authenticate("bar@foo.com",@attr[:password])
          user.should be_nil
        end
        it "should return the user on email/password match" do
          user = User.authenticate(@attr[:email],@attr[:password])
          user.should == @user
        end
      end
      
    end
    
  end
  
end
