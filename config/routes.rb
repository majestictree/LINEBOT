Rails.application.routes.draw do
  post '/callback' => 'webhooks#callback'
end
