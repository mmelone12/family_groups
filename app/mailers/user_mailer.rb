class UserMailer < ActionMailer::Base
  default :from => "contact@familygroups.com"
  
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
    @user = User.find(recipient.user_id)
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{recipient.email} <#{recipient.email}>", :subject => "You've been invited by a friend to join Family Groups")
  end

  def friended(friendship)
    @friendship = friendship
    friend = User.find(friendship.friend_id)
    @friend = User.find(friendship.friend_id)
    @user = User.find(friendship.user_id)
    attachments["family_groups.png"] = File.read("#{Rails.root}/app/assets/images/fglogo1.png")
    mail(:to => "#{friend.name} <#{friend.email}>", :subject => "You've just been friended by someone on Family Groups")
  end
end