ActionMailer::Base.smtp_settings = {
  :address              => "aspmx.l.google.com",
  :port                 => 25,
  :domain               => "familygroups.org",
  :user_name            => "contact",
  :password             => "seesaw1985!",
  :authentication       => "plain",
  :enable_starttls_auto => true,
}

ActionMailer::Base.default_url_options[:host] = "http://familygroups.org"