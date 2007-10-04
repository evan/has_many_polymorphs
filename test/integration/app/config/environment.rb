
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = { :session_key => "_myapp_session", :secret => "this is a super secret phrase" }
  config.load_paths << "#{RAILS_ROOT}/app/models/person" # moduleless model path
end

# Dependencies.log_activity = true
