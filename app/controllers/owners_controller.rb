class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do
    @pets = Pet.all 
    erb :'/owners/new'
  end

  post '/owners' do 
  #binding.pry
  @owner = Owner.create(params[:owner])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    @owner = Owner.find_by_id(params[:id])
    @owner.name = params[:name]
    @owner.pets << Pet.create(name: params["pet"]["name"])
    @owner.save
    redirect "owners/#{@owner.id}"
  end
end