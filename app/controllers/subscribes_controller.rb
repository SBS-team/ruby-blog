class SubscribesController < ApplicationController

  def new

  end

  def create
    @sub = Subscribe.new()
    if @sub.save
      redirect_to posts_path, notice: 'A mail was sent to your address to confirm it'
    else
      render nothing: true, notice: 'Enter a valid email'
    end
  end

  def unsubscribe

  end

  private

  def sub_params
    params.permit(:email, :confirmed_at, :sub_token, :unsub_token)
  end

end