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

class Note < ActiveRecord::Base
end

get '/' do
  haml :index, :layout => false
end