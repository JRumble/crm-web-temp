
require 'sinatra'
require './Rolodex'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!



$rolodex = Rolodex.new
#$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

#begin sinatra routes

get '/' do
	@crm_name = "the Steelers Fan Zone!"
	erb :index
end

get '/contact' do
  	@contacts = Contact.all
  	#@contacts = $rolodex.contacts
  	#@ contacts[]
  	erb :contact
  end

  get '/contacts/new' do
   erb :newcontact
 end

 post '/contacts' do
   #contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
   contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
    )
   #$rolodex.add_contact(contact)
   redirect to('/contact')
 end

# get "/contacts/:id" do
#  @contact = $rolodex.find(params[:id].to_i)
#  erb :show_contact
# end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end


get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  #@contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
    #erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  #@contact = $rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.save

    redirect to("/contact")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  #@contact = $rolodex.find(params[:id].to_i)
  @contact = Contact.get(params[:id].to_i)
  if @contact
    ##$rolodex.remove_contact(@contact)
    @contact.destroy
    redirect to("/contact")
  else
    raise Sinatra::NotFound
  end
end

