Rails.application.routes.draw do
  post '/callback' => 'webhooks#callback'
  get '/push' => 'webhooks#push'
end
