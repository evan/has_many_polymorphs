
require 'initializer'

class Rails::Initializer #:nodoc:

  module HasManyPolymorphsAutoload
    
    mattr_accessor :options
    @@options = HashWithIndifferentAccess.new({
      :file_pattern => "#{RAILS_ROOT}/app/models/**/*.rb",
      :file_exclusions => ['svn', 'CVS', 'bzr'],
      :methods => ['has_many_polymorphs', 'acts_as_double_polymorphic_join'],
      :requirements => []
    })      

=begin rdoc
Searches for models that use <tt>has_many_polymorphs</tt> or <tt>acts_as_double_polymorphic_join</tt> and makes sure that they get loaded during app initialization. This ensures that helper methods are injected into the target classes. 
    
Overrides Rails::Initializer#after_initialize.
=end
  
    def after_initialize_with_autoload
      after_initialize_without_autoload

      _logger_debug "has_many_polymorphs: autoload hook invoked"
      
      HasManyPolymorphsAutoload.options[:requirements].each do |requirement|
        require requirement
      end
    
      Dir[HasManyPolymorphsAutoload.options[:file_pattern]].each do |filename|
        next if filename =~ /#{HasManyPolymorphsAutoload.options[:file_exclusions].join("|")}/
        open filename do |file|
          if file.grep(/#{HasManyPolymorphsAutoload.options[:methods].join("|")}/).any?
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
    
  end
  
  include HasManyPolymorphsAutoload
    
  alias_method_chain :after_initialize, :autoload
end
