require 'sinatra' 
require 'sinatra/activerecord'

db = URI.parse('postgres://user:pass@localhost/dbname')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => 'postgres',
  :password => 'pass',
  :database => 'contacts',
  :encoding => 'utf8'
)

class Client < ActiveRecord::Base
	validates :client_name, presence: true, length: {minimum: 5}
end

get '/' do 
	@clients = Client.all
  haml :index
end

get '/clients/new' do
  haml :client_form
end

post '/clients/new' do
  @client = Client.create(params[:client])
  if @client.save  
    redirect to('/')
  else
    redirect to('/clients/new')
  end
end

get "/clients/:id" do
  @client = Client.find(params[:id])
  haml :client
end

delete '/delete/clients/:id' do
  Client.find(params[:id]).destroy
  redirect to('/')
end
