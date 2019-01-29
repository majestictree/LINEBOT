class ApplicationController < ActionController::Base
  include WebhooksHelper
  include GarbageHelper
end
