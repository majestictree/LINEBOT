class ApplicationController < ActionController::Base
  include WebhooksHelper
  include GarbageHelper
  include BustimeHelper
end
