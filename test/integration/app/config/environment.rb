
RAILS_GEM_VERSION = ENV['MULTIRAILS_RAILS_VERSION'] if ENV['MULTIRAILS_RAILS_VERSION']

require File.join(File.dirname(__FILE__), 'boot')
require 'action_controller'

Rails::Initializer.run do |config|
  
  if ActionController::Base.respond_to? 'session='
    config.action_controller.session = {:session_key => '_app_session', :secret => '22cde4d5c1a61ba69a817953'}
  end
  
  config.load_paths << "#{RAILS_ROOT}/app/models/person" # moduleless model path
end

# Dependencies.log_activity = true

ENV['RAILS_ASSET_ID'] = Time.now.to_i.to_s

require 'tagging_extensions'
