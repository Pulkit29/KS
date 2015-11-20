class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone_number, type: Integer
  field :otp_generation_time, type: Time
  field :otp, type: Integer
  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :pin, type: Integer

  field :auth_token, type: String

  def generate_access_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.where(auth_token: auth_token).exists?
    self.save!
  end

  def generateOTP
    self.otp = rand(000000..999999).to_s.rjust(6, "0")
    self.otp_generation_time = Time.now
    self.save!
  end

  def sendOTP
	self.sendMsg	
  end

  def sendMsg
  	Mvaayoo.send_message "#{self.otp}", "#{self.phone_number}"

	  # rescue Faraday::ConnectionFailed
  end

end
