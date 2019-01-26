Rails.application.routes.draw do
  get '/' => 'webhooks#push'
  post '/callback' => 'webhooks#callback'
end
