require 'sinatra'

get '/' do
	"Hello World!"
end
# ------------------------------------------------------------------------------------------------------------------

get '/about' do
	"A little tall tale about me."
end
# ------------------------------------------------------------------------------------------------------------------

#  Here we are setting a Route where anyting after /hellow will be contained in the param ARRAY with the key NAME
#  You can set the Route to accept multiple query string values like NAME and CITY

get '/hello/:name/:city' do
	"Why hello there, #{params[:name].upcase}, from #{params[:city].upcase}!"
end
# -----------------------------------------------------------------------------------------------------------------

#  Here we can use a wildcard (*) to accept anything we want into the params array

get '/more/*' do
	params[:splat]
end
# ----------------------------------------------------------------------------------------------------------------

#  Creating a form to accept input from the user

get '/form' do
	erb :form
end

post '/form' do
	"You said '#{params[:message]}'."
end
# ----------------------------------------------------------------------------------------------------------------

#  Creating an 'encypted' message

get '/secret' do
	erb :secret
end

post '/secret' do
	params[:secret].reverse
end

#  Decrypting our 'secret' message

get '/decrypt/:secret' do
	params[:secret].reverse
end
# ----------------------------------------------------------------------------------------------------------------

#  Handling 404s

not_found do
	halt 404, 'Not found, please ask the genie again!'
end
