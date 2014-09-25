require 'sinatra'
require 'timezone'

get '/form' do
	@title = "New Post"
	erb :form
end
post '/form' do

	cityInput = params[:message]
	if cityInput.include? " "
		cityInput[" "] = "_"
	end
	timezones = Timezone::Zone.names
	This_city = timezones.find{
		|e|/#{cityInput}/ =~e 
	}
	This_timezone = Timezone::Zone.new :zone => This_city
	time_display = This_timezone.time Time.now
	array = time_display.to_s.split(' ')
	time = array[1].split(':')
	hrs = time[0]
	mins = time[1]

	if cityInput.include? "_"
		cityInput["_"] = " "
	end


	if hrs.to_i > 12
		hours = hrs.to_i - 12
		time = "#{hours}:#{mins} PM"
		erb :current_time, :locals => {:time => time,:message => cityInput}
		
	else
		time = "#{hrs}:#{mins} AM"
		erb :current_time, :locals => {:time => time,:message => cityInput}
		
	end

	
	# "The current time in #{params[:message]} is : #{timeS}"
end


	

