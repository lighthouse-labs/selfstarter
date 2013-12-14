require 'spec_helper'

describe OrdersController do

  describe "GET 'new' " do

    it "should create a new user" do
      get 'new'
      expect(assigns[:user]).to be_a_new(User)
    end

    it "should create a new order" do
      get 'new'
      expect(assigns[:order]).to be_a_new(Order)
    end
    
    it "should render the new.html.erb template" do
      get 'new'
      expect(response).to be_success
      expect(response).to render_template(:new)
    end 

  end
  
  describe "POST 'create' " do

    before :each do
      @user = FactoryGirl.build :user
      @order_attrs = FactoryGirl.attributes_for :authenticated_order
    end

    it "should create order with set parameters" do
      post 'create', stripeToken: "123456", order: @order_attrs, email: @user.email
      expect(assigns[:order].zip).to eq(@order_attrs[:zip])
    end
     
    it "should set order to new user with email" do
      post 'create', stripeToken: "123456", order: @order_attrs, email: @user.email
      expect(assigns[:order].user.email).to eq(@user.email)
    end
    it "should redirect to root if order is saved" do
      post 'create', stripeToken: "123456", order: @order_attrs, email: @user.email
      expect(response).to redirect_to :root
    end
    it "should set the notice when order is saved" do
      post 'create', stripeToken: "123456", order: @order_attrs, email: @user.email
      expect(flash[:notice]).to eq("Thanks champ")
    end
    it "should render the new.html.erb file if order cannot be saved" do
      Order.any_instance.stub(:save).and_return(false)
      post 'create', stripeToken: "123456", order: @order_attrs, email: @user.email
      expect(response).to render_template(:new)
    end
    
  end
end