RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"

module APIS
	module_function

		def meetup
			@meetup ||= Rmeetup::Client
		end
	end
end