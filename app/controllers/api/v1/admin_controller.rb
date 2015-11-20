class Api::V1::AdminController < ApplicationController
	def index


		
	end

	def testMvaayoo
	    Mvaayoo.send_message "hey there!!", "9871912255"
	end
end
