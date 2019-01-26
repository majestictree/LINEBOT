Rails.application.routes.draw do
  post '/callback' => 'webhooks#callback'
  root 'webhooks#push'
end
