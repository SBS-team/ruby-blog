class Subscribe < ActiveRecord::Base

  after_create :send_confirmation

  validates :email, format: {with: Devise.email_regexp}, uniqueness: true, presence: true

  def send_confirmation
    AdminMailer.subscription_notifier(self).deliver
  end

end
