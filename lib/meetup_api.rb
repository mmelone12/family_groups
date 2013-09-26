# encoding: utf-8
class MeetupApi
  require 'rmeetup'
  
  #TODO: make the key configurable
  def initialize()
    RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
    end

  def fetch(type, options)
    RMeetup::Client.fetch(type.to_sym, options)  
  end
end