class Subscribe < ActiveRecord::Base

  after_create :send_confirmation

  validates :email, uniqueness: true, presence: true, format: {with: Devise.email_regexp}

  def send_confirmation
    AdminMailer.subscription_notifier(self).deliver
  end

end
