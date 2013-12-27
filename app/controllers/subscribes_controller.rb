class SubscribesController < ApplicationController

  def create
    @sub = Subscribe.new(sub_params)
    @sub.sub_token = SecureRandom.urlsafe_base64(nil, false)
    @sub.unsub_token = SecureRandom.urlsafe_base64(nil, false)
    if @sub.save
      redirect_to :back, notice: 'A mail was sent to your address to confirm it'
    else
      redirect_to :back, notice: 'Enter a valid email'
    end
  end

  def subscribe
    conf = Subscribe.find_by_sub_token(params[:sub_token])
    if conf
      conf.confirmed_at = DateTime.now
      conf.sub_token = nil
      conf.save
    else
      redirect_to root_path, notice: 'Email already saved'
    end
  end

  def unsubscribe

  end

  private

  def sub_params
    params.require(:subscribe).permit(:email, :confirmed_at, :sub_token, :unsub_token)
  end

end