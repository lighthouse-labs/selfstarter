require 'spec_helper'

describe Admin::OrdersController do

  context "get 'show'" do
    it "renders json" do
      http_login
      order = FactoryGirl.create :order
      expect(Order).to receive(:daily_count).and_return(true)
      get 'show', format: :json
      expect(response.body).to eq("true")
    end
  end
end
