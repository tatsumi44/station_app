require 'bundler/setup'
Bundler.require
require 'sinatra/reloader'
require 'open-uri'
require 'net/http'
require 'json'
require 'sinatra/activerecord'
require './models'
enable :sessions

get '/' do
  @histories = History.all.limit(10).order("created_at desc")
  @favorites = History.where(favorite1: true)
  p session[:contents_id]
  p @histories
  erb :form
end

get '/next' do
  uri = URI('http://express.heartrails.com/api/json')
  uri.query = URI.encode_www_form({
                                      method: "getStations",
                                      line: params[:line],
                                      name: params[:name]

                                  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  response = {
      next: json["response"]["station"][0]["next"]
  }
  JSON response
end

get '/list' do
  uri = URI('http://express.heartrails.com/api/json')
  uri.query = URI.encode_www_form({
                                      method: "getStations",
                                      x: params[:x],
                                      y: params[:y]
                                  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  @station = json["response"]["station"]
  p @station[0]["name"]
  History.create!(x: params[:x],y: params[:y],station_name: @station[0]["name"])
  erb :main
end

post '/:id/delete' do
  history = History.find(params[:id])
  history.delete
  redirect '/'
end

post '/:id/update' do
  history = History.find(params[:id])
  history.favorite1 = !history.favorite1
  history.save
  redirect '/'
end

post '/:id/update_contents' do
  @id = params[:id]
  p params[:id]
  session[:contents_id] = params[:id]
  p session[:contents_id]
  erb :update
end
post '/:id/update_result' do
  new_x = params[:new_x]
  new_y = params[:new_y]
  p session[:contents_id]
  uri = URI('http://express.heartrails.com/api/json')
  uri.query = URI.encode_www_form({
                                      method: "getStations",
                                      x: new_x,
                                      y: new_y
                                  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  @station = json["response"]["station"]
  @id = params[:id]
  history = History.find(@id)
  history.x = params[:new_x]
  history.y = params[:new_y]
  history.station_name = @station[0]["name"]
  history.save
  erb :main
end
