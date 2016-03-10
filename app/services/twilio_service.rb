require 'twilio-ruby'
class TwilioService

  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  def welcome_message(number)
    client.messages.create(
      from: "+17208975626",
      to: "+1" + "#{number}",
      body: "Thanks for signing up for Snow Dashboard's text notifications. You will receive message alerts about your favorite mountains!"
    )  end

  def send_sms(number)
    client.messages.create(
      from: "+17208975626",
      to: "+1" + "#{number}",
      body: 'Testing, texting, resting!'
    )
  end


end
