class EventsController < ApplicationController

    def new
      @event = Event.new
    end

    def create
      @timeslot = Timeslot.find(params[:timeslot])
      @timeslot.proposal.set_time
      @event = Event.new
      @timeslot.proposal.event = @event
      @event.title = @timeslot.proposal.title


      if @timeslot.proposal.save && @event.save
          @event.add_to_calendar(current_user)
          redirect_to proposal_path(@timeslot.proposal)
      else
        redirect_to proposal_path(@proposal), notice: "Your event did not save."
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
