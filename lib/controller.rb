require 'pry'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  get '/gossips/:id/' do 
    erb :show, locals: {gossip_ided: Gossip.find(params['id'].to_i), id: params['id'].to_i }
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'].to_i}
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save_as_csv
    redirect '/'
  end

  post '/gossips/:id/edit/' do
    @params = params  
    Gossip.new(params["gossip_edit_author"],params["gossip_edit_content"]).update(params['id'].to_i)
    redirect "/gossips/#{params['id']}/"
    
  end
end