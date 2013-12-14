describe Order do

  context "attributes" do

    # [:address_one, :address_two, :city, :country, :number, :state, :status,
    #   :token, :transaction_id, :zip, :shipping, :tracking_number, :price, :phone, :expiration
    #   ].each do |property|
    #     it { should allow_mass_assignment_of property }
    #   end

    #   it { should_not allow_mass_assignment_of :uuid }

      it "generates UUID before validation on_create" do
        @order = Order.new
        @order.valid?
        @order.uuid.should_not be_nil
      end

      it { Order.primary_key.should == 'uuid' }

    end

  context "class methods" do

    describe ".prefill!" do

      before do
        @options = {
          user_id: 12983,
          price: 123.12
        }
        @order = Order.prefill!(@options)
      end

      it "sets user_id" do
        @order.user_id.should == @options[:user_id]
      end

      it "sets the price" do
        @order.price.should == @options[:price]
      end

      it "saves" do
        Order.any_instance.should_receive :save!
        Order.prefill!(@options)
      end

      it "uses the right order number" do
        numbah = Order.next_order_number
        Order.prefill!(@options).number.should == numbah
      end

    end

    describe ".postfill!" do
      before do
        @order = FactoryGirl.create(:order)
        @options = {
          callerReference: @order.uuid,
          tokenID: 128736127863,
          addressLine1: '102 Fake address',
          addressLine2: 'Apt 12, 3rd fl',
          city: 'Mountain View',
          state: 'CA',
          status: 'IN PROGRESS',
          zip: '94041',
          phoneNumber: '650 219 9382',
          country: 'United States',
          expiry: (Time.now + 99999).to_s
        }
      end

      it "finds order by uuid" do
        @order = Order.postfill!(@options)
        encoded_uuid = @options[:callerReference].force_encoding('UTF-8')
        Order.find_by!(uuid: encoded_uuid).should_not be_nil
      end

      it "sets the token" do
        @order = Order.postfill!(@options)
        @order.token.should == @options[:tokenID]
      end

      it "checks if token is present" do
        @order = Order.postfill!(@options)
        @order.token.should_not be_nil
      end

      it "sets addresses" do
        @order = Order.postfill!(@options)
        @order.address_one.should == @options[:addressLine1]
        @order.address_two.should == @options[:addressLine2]
      end

      it "sets city" do
        @order = Order.postfill!(@options)
        @order.city.should == @options[:city]
      end

      it "sets state" do
        @order = Order.postfill!(@options)
        @order.state.should == @options[:state]
      end

      it "sets status" do
        @order = Order.postfill!(@options)
        @order.status.should == @options[:status]
      end

      it "sets zip" do
        @order = Order.postfill!(@options)
        @order.zip.should == @options[:zip]
      end

      it "sets country" do
        @order = Order.postfill!(@options)
        @order.country.should == @options[:country]
      end

      it "sets phone" do
        @order = Order.postfill!(@options)
        @order.phone.should == @options[:phoneNumber]
      end

      it "sets expiration" do
        @order = Order.postfill!(@options)
        @order.expiration.should == Date.parse(@options[:expiry])
      end

      it "saves" do
        Order.any_instance.should_receive :save!
        Order.postfill!(@options)
      end

    end


    describe ".next_order_number" do

      it "gives the next number" do
        FactoryGirl.create :order # has #number => 1
        Order.next_order_number.should == 2
      end

      context "no orders" do

          before do
            ActiveRecord::Relation.any_instance.stub(:first).and_return(nil)
            Order.stub!(:count).and_return(0)
          end

          it "doesn't break if there's no orders" do
            expect { Order.next_order_number }.to_not raise_error
          end

          it "returns 1 if there's no orders" do
            Order.next_order_number.should == 1
          end

      end

    end

    describe ".percent" do
      it "calculates the percent based on #goal and #revenue" do
        Order.stub(:revenue).and_return(6.2)
        Order.stub(:goal).and_return(2.5)

        Order.percent.should == 2.48 * 100
      end
    end

    describe ".goal" do
      pending it "returns the project goal from Settings" do
        Order.goal.should == Settings.project_goal
      end
    end

    describe ".revenue" do
      it "returns the sum of all the completed orders" do
        #Order.stub(:revenue).and_return(4)
        #Settings.stub(:price).and_return(6)
        FactoryGirl.create :completed_order, price: 20
        FactoryGirl.create :completed_order, price: 20
        Order.revenue.should == 40
      end
    end

    describe ".backers" do
      it "returns the number of orders with valid token / that have been postfilled" do
        Order.delete_all
        order = Order.prefill!(user_id: 1, price: 123.21)
        Order.backers.should == 0

        Order.postfill!(callerReference: order.uuid, tokenID: '1232', expiry: '2015-12-24')
        Order.backers.should == 1
      end
    end

  end


  describe "validators" do

    it { should validate_presence_of :price }
    it { should validate_presence_of :user_id }

  end

end