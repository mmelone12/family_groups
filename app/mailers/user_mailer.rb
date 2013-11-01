class UserMailer < ActionMailer::Base
  default :from => "matt.m.melone@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end