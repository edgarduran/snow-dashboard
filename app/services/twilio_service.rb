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

  def send_mms
    # @client.messages.create(
    # from: '+14159341234',
    # to: '+16105557069',
    # body: 'Hey there!',
    # media_url: 'http://example.com/smileyface.jpg'
    # )
  end


end
