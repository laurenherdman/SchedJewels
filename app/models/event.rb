#require 'google/apis/calendar_v3'
#require 'googleauth'
require 'google/api_client'

class Event < ActiveRecord::Base


	after_commit on: :create

	# def to_google_event(user)
	# 		 # @user = user.id
 #       google_event = { 'summary' => self.title, 'description' => self.description, 'location' => self.location, 'start' => {'dateTime' => self.start_time}, 'end' => {'dateTime' => self.end_time} }

 #      client = Google::APIClient.new
 #      client.authorization.access_token = current_user.token
 #      service = client.discovered_api('calendar', 'v3')
 #    #  	 service = Google::Apis::CalendarV3::CalendarService.new
 # 			# scopes =  [Google::Apis::CalendarV3::AUTH_CALENDAR]
 #    # 	authorization = Google::Auth.get_application_default(scopes)
 #    # 	storage.authorization = authorization
 #       # service.authorization = Google::Auth.get_application_default(Google::Apis::CalendarV3::AUTH_CALENDAR)
 #       event = Google::Apis::CalendarV3::Event.new
 #       # ({'summary' => self.title, 'description' => self.description, 'location' => self.location, 'start' => {'dateTime' => self.start_time}, 'end' => {'dateTime' => self.end_time}})
 #       event = service.insert_event('schedjewelsapp@gmail.com', event)

 #       self.google_event_id = result.data.id
 #       self.save
	# end

	# def authorize
	#   # FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

	#   file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
	#   storage = Google::APIClient::Storage.new(file_store)
	#   auth = storage.authorize

	#   if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
	#     app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
	#     flow = Google::APIClient::InstalledAppFlow.new({
	#       :client_id => "53893121832-2scbeii78nlf3e647i7nnd4mva8coi2d.apps.googleusercontent.com",
	#       :client_secret => "DfEeUhbEPMQvoXpRxvzMeRme",
	#       :scope => SCOPE})
	#     auth = flow.authorize(storage)
	#     puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
	#   end
	#   auth
	# end

  def google_client(user)
  	# user = self.user
    # Application name is what you named it in Google Developer Console
    google_api_client = Google::APIClient.new({
      application_name: 'schedjewels2'
    })
    google_api_client.authorization = Signet::OAuth2::Client.new({
      client_id: "53893121832-2scbeii78nlf3e647i7nnd4mva8coi2d.apps.googleusercontent.com",
      client_secret: "DfEeUhbEPMQvoXpRxvzMeRme",
      access_token: user.token
    })
    return google_api_client
  end

	def get_all_calendars(user)
	  client = google_client(user)
	  service = client.discovered_api('calendar', 'v3')
	  @result = client.execute(
	    :api_method => service.calendar_list.list,
	    :parameters => {},
	    :headers => {'Content-Type' => 'application/json'})
	end

end
