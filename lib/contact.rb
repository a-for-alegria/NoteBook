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
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
end

class Project < ActiveRecord::Base
  validates :project_name, presence: true
end

#---------------Global handlers-----#

get '/' do 
  haml :index
end

#---------------Projects handlers-----#

get '/projects' do 
  @projects = Project.where(archived: false)
  haml :projects
end

get '/projects/new' do
  @clients = Client.all
  haml :project_form
end

post '/projects/new' do
  @project = Project.create(params[:project])
  if @project.save  
    redirect to('/projects')
  else
    redirect to('/projects/new')
  end
end

get "/projects/:id" do
  @project = Project.find(params[:id])
  haml :project_show
end

get "/archived_projects" do
  @archived_projects = Project.where(archived: true)
  haml :archived_projects
end

delete '/delete/projects/:id' do
  Project.find(params[:id]).destroy
  redirect to('/projects')
end

# post '/archived_projects/:id' do
#   Project.find(params[:id]).toggle(:archived)
#   redirect to("/projects")
# end

# post '/restore/projects/:id' do
#   Project.find(params[:id]).toggle(:archived)
#   redirect to("/projects")
# end


#---------------Clients handler-----#

get '/clients' do 
  @clients = Client.all
  @projects = Project.all
  haml :clients
end

get '/clients/new' do
  haml :client_form
end

post '/clients/new' do
  @client = Client.create(params[:client])
  if @client.save  
    redirect to('/clients')
  else
    redirect to('/clients/new')
  end
end

get "/clients/:id" do
  @client = Client.find(params[:id])
  haml :client_show
end

delete '/delete/clients/:id' do
  Client.find(params[:id]).destroy
  redirect to('/clients')
end

