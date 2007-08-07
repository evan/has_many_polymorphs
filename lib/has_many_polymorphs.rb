
require 'active_record'

require 'has_many_polymorphs/reflection'
require 'has_many_polymorphs/association'
require 'has_many_polymorphs/class_methods'

require 'has_many_polymorphs/support_methods'
require 'has_many_polymorphs/base'

class ActiveRecord::Base
  extend ActiveRecord::Associations::PolymorphicClassMethods 
end

if ENV['HMP_DEBUG'] or (ENV['RAILS_ENV'] =~ /development|test/ and ENV['USER'] == 'eweaver')
  _logger_warn "has_many_polymorphs: debug mode enabled"
  require 'has_many_polymorphs/debugging_tools' 
end

if defined? Rails and RAILS_ENV and RAILS_ROOT
  _logger_warn "has_many_polymorphs: Rails environment detected"
  require 'has_many_polymorphs/dependencies'
  require 'has_many_polymorphs/autoload'
end

_logger_debug "has_many_polymorphs: loaded ok"
