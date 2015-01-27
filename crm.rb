
require 'sinatra'
require './Contact'
require './Rolodex'


$rolodex = Rolodex.new


get '/' do
  @crm_name = "Rumble's CRM"
  erb :index
end

get '/contact' do
	@contacts = $rolodex.contact
	  #@ contacts[]
	  # @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
	  # @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
	  # @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")
  erb :contact
end
	

get '/contacts/new' do
	erb :newcontact
end

post '/contacts' do
	contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  	$rolodex.add_contact(contact)
  	redirect to('/contact')
end

