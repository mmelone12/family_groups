ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "familygroups.org",  
  :user_name            => "contact",  
  :password             => "seesaw1985!",  
  :authentication       => "plain",  
  :enable_starttls_auto => true   
}

ActionMailer::Base.default_url_options[:host] = "http://familygroups.org"