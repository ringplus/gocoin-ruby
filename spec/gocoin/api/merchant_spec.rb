require 'spec_helper'

describe GoCoin::Merchant do
	
	before :each do
		# Values for GET /merchants/:id API behavior (#get)
		@get_merchant_id = 'getmerchantid'
		@get_route = "/merchants/#{@get_merchant_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for PATCH /merchants/:id API behavior (#update)
		@update_merchant_id = 'updatemerchantid'
		@update_params = {
		  name: "Blingin' Merchant", 
		  address_1: "123 Main St."
		  # more is unnecessary
		}
		@update_route = "/merchants/#{@update_merchant_id}"
		@update_options = {
			method: 'PATCH',
			payload: @update_params
		}
		@update_api_return_hash = 'mock_update_api_return_hash'

		@merchant = GoCoin::Merchant.new(@api = double(GoCoin::API))
		@api.stub(:client).and_return(GoCoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@update_route, @update_options).and_return(@update_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@merchant.get(@get_merchant_id).should == @get_api_return_hash
    end

	end

	describe "'update' method" do

    it 'should return the correct result' do
    	@merchant.update(@update_merchant_id, @update_params).should == @update_api_return_hash
    end

	end

end