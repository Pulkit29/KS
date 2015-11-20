class Api::V1::CustomersController < ApplicationController

	def create
		@customer = Customer.find_by(:phone_number => params[:phone_number]) rescue nil
			if !@customer
				@customer = Customer.create!(customer_params)	
			end
			@customer.generate_access_token
			@customer.generateOTP
			@customer.save!
			if @customer.sendOTP

				render :json =>{
					:success => true,
					:message => 'OTP sent successfully'
				}
			else
				render :json =>{
					:success => false,
					:message => 'OTP not sent'
				}
			end
	end

	private
	def customer_params
		params.permit(:phone_number)
	end
end
