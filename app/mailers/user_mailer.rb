class UserMailer < ActionMailer::Base
  default :from => "matt.m.melone@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end

  def you_got_mail(recipient)
    @recipient = recipient
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{recipient.name} <#{recipient.email}>", :subject => "You've received mail")
  end

  def invite(recipient)
    @recipient = recipient
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{recipient.email} <#{recipient.email}>", :subject => "You've been invited by a friend to join Family Groups")
  end
end