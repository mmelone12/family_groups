RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"

module AOK
  module APIS
	module_function

	  def meetup
		@meetup ||= RMeetup::Client
	  end

  end
end