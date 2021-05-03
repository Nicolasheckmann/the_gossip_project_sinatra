require 'pry'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  get '/gossips/:id/' do 
    erb :show, locals: {gossip_ided: Gossip.find(params['id'].to_i), id: params['id']}
  end

  post '/gossips/new/' do
    # Gossip.new(params["gossip_author"],params["gossip_content"]).save_as_json
    Gossip.new(params["gossip_author"],params["gossip_content"]).save_as_csv
    puts Gossip.all
    redirect '/'
  end
end