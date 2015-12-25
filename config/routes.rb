Rails.application.routes.draw do

  root 'list#index'

  get '/sync', to: 'list#sync'
end
