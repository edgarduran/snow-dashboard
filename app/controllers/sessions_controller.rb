class SessionsController < ApplicationController

  def create
    user = User.find_or_create_from_oauth(request.env["omniauth.auth"])
    if user
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      redirect_to "/"
    end
  end

  def edit
    user = User.find(params[:id])
    if user.update_attributes(phone_number: "#{params[:phone_number]}")
      redirect_to dashboard_index_path
      flash[:success] = "You have successfully added a number to your account."
      twilio_service.welcome_message(params[:phone_number])
    else
      redirect_to dashboard_index_path
      flash[:error] = "You must enter a valid phone #."
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end

  private

  def twilio_service
    TwilioService.new
  end

end
