class EventsController < ApplicationController

    def new
      @event = Event.new
    end

    def create
     @event = Event.new(event_params)

     if @event.save

       render :nothing => true
       google_event = { 'summary' => @event.title, 'description' => @event.description, 'location' => @event.location, 'start' => {'dateTime' => @event.start_time}, 'end' => {'dateTime' => @event.end_time} }

       client = Google::APIClient.new
       client.authorization.access_token = current_user.token
       service = client.discovered_api('calendar', 'v3')

       result = client.execute(:api_method => service.events.insert,
                               :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'sendNotifications' => true},
                               :body => JSON.dump(google_event),
                               :headers => {'Content-Type' => 'application/json'})

       @event.google_event_id = result.data.id
       @event.save
     else
       render :nothing => true
     end
   end

    def index
      @events = Event.all
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      if @event.destroyed?
        unless @event.google_event_id.nil?
          client = Google::APIClient.new
          client.authorization.access_token = current_user.token
          service = client.discovered_api('calendar', 'v3')
          result = client.execute(:api_method => service.events.delete,
                                  :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' => @event.google_event_id})
        end
      end
      redirect_to events_path, notice: "#{@event.title} - has been removed."
    end

    def update
    @event = Event.find(params[:id])


    if @event.update(event_params)
      render :nothing => true

      unless @event.google_event_id.nil?
        client = Google::APIClient.new
        client.authorization.access_token = current_user.token
        service = client.discovered_api('calendar', 'v3')

        result = client.execute(:api_method => service.events.get, :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' => @event.google_event_id } )

        event = result.data
        event.summary = @event.title
        event.start.dateTime = @event.start_time
        event.end.dateTime = @event.end_time
        event.description = @event.description
        event.location = @event.location

        result = client.execute(:api_method => service.events.update,
                                :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' =>  @event.google_event_id},
                                :body_object => event,
                                :headers => {'Content-Type' => 'application/json'})
      end
    else
      render :nothing => true
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_time, :end_time)
    end
end
