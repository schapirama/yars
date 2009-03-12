class AccountsNotifier < ActionMailer::Base
  
  def password_reminder(email, id)
    recipients email
    subject "#{SYSTEM_NAME} - Your password has changed"
#    from "#{SYSTEM_NAME} account management (accounts@#{SYSTEM_NAME})"
    body :id => id
  end
  
end
