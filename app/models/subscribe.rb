class Subscribe < ActiveRecord::Base

  after_create :send_confirmation

  validates :email, format: {with: Devise.email_regexp}, uniqueness: true

  def send_confirmation
    p 'Start sending **********************************************************'
    AdminMailer.subscription_notifier(self).deliver

    p 'Finished ***************************************************************'
  end

end
