require 'spec_helper'

describe UsersController do
	it "should successfully send a sign up email after the creation of a user" do
		@user = FactoryGirl.build :user
		post :create, user: FactoryGirl.attributes_for(:user)
		ActionMailer::Base.deliveries.should_not be_empty
	end

	it "should successfully create a new user in the database" do
		expect {
			@user = FactoryGirl.build :user
			post :create, user: FactoryGirl.attributes_for(:user)
			}.to change(User, :count).by(1)		
		assigns(:user).should be_a(User)
	end
	
	it "should render#new on an unsuccessful creation of a user" do
		@user = FactoryGirl.build :user, email: nil
		get :new, user: FactoryGirl.attributes_for(:user)
		expect(@user.errors.full_messages).to_not be_nil
	end

end