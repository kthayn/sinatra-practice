require 'sinatra'
require 'data_mapper'

#  Setting up the SQLite3 db  ---------------------------------------------------------------
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

#  Setting up the Notes table in the db  ----------------------------------------------------
#  While calling class Note DataMapter will create the table as Notes (plural)
#  Notes is a table in the db schema which consists of 5 fields (properties)

class Note
	include DataMapper::Resource
	property :id, Serial	# This is an auto-incrementing integer primary key field
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

#  Setting to automatically update the db  --------------------------------------------------- 
#  Will update anytime changes are made to the schema

DataMapper.finalize.auto_upgrade!


#  READ/GET:  Displays all Notes stored in the db  ------------------------------------------------
get '/' do
	@notes = Note.all :order => :id.desc
	@title = 'My Memory Is Better Than Yours'
	erb :home
end

#  CREATE/POST:  This creates a new db row (Note) in the Notes table  -------------------------------
post '/' do
	n = Note.new
	n.content = params[:content]
	n.created_at = Time.now
	n.updated_at = Time.now
	n.save
	redirect '/'
end

#  UPDATE/PUT:  Route to allow for editing existing notes  ------------------------------------------
get '/:id' do
	@note = Note.get params[:id]
	@title = "Edit note ##{params[:id]}"
	erb :edit
end

put '/:id' do
	n = Note.get params[:id]
	n.content = params[:content]
	n.complete = params[:complete] ? 1 : 0  #  ternary operator to set n.complete to 1 if params[:complete] exists, or 0 otherwise
	n.updated_at = Time.now
	n.save
	redirect '/'
end

#  DELETE:  Deleting a note  -------------------------------------------------------------------------
get '/:id/delete' do
	@note = Note.get params[:id]
	@title = "Confirm deletion of note ##{params[:id]}"
	erb :delete
end

delete '/:id' do
	n = Note.get params[:id]
	n.destroy
	redirect '/'
end

#  Complete/un-complete note  -------------------------------------------------------------------------
get '/:id/complete' do
	n = Note.get params[:id]
	n.complete = n.complete ? 0 : 1 # flip it
	n.updated_at = Time.now
	n.save
	redirect '/'
end




