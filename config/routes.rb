Rails.application.routes.draw do
  root 'webhooks#push'
  post '/callback' => 'webhooks#callback'
end
