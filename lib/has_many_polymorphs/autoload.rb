
require 'initializer'

class Rails::Initializer

=begin rdoc
Searches for models that use <tt>has_many_polymorphs</tt> or <tt>acts_as_double_polymorphic_join</tt> and makes sure that they get loaded during app initialization. This ensures that helper methods are injected into the target classes. 

Overrides Rails::Initializer#after_initialize.
=end

  def after_initialize_with_autoload
    after_initialize_without_autoload
  
    _logger_debug "has_many_polymorphs: autoload hook invoked"
    Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each do |filename|
      next if filename =~ /svn|CVS|bzr/
      open filename do |file|
        if file.grep(/has_many_polymorphs|acts_as_double_polymorphic_join/).any?
          begin
            model = File.basename(filename)[0..-4].camelize
            _logger_warn "has_many_polymorphs: preloading parent model #{model}"
            model.constantize
          rescue Object => e
            _logger_warn "has_many_polymorphs: WARNING; possibly critical error preloading #{model}: #{e.inspect}"
          end
        end
      end
    end
  end  
  
  alias_method_chain :after_initialize, :autoload
end
