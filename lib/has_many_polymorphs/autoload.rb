
require 'dispatcher'

module HasManyPolymorphs

=begin rdoc    
Searches for models that use <tt>has_many_polymorphs</tt> or <tt>acts_as_double_polymorphic_join</tt> and makes sure that they get loaded during app initialization. This ensures that helper methods are injected into the target classes. 

Note that you can override DEFAULT_OPTIONS via Rails::Configuration#has_many_polymorphs_options. For example, if you need an application extension to be required before has_many_polymorphs loads your models, add an <tt>after_initialize</tt> block in <tt>config/environment.rb</tt> that appends to the <tt>'requirements'</tt> key:
  Rails::Initializer.run do |config|     
    # your other configuration here
    
    config.after_initialize do
      config.has_many_polymorphs_options['requirements'] << '/lib/my_extension'
    end    
  end
  
=end

  module Autoload
        
    DEFAULT_OPTIONS = {
      :file_pattern => "#{RAILS_ROOT}/app/models/**/*.rb",
      :file_exclusions => ['svn', 'CVS', 'bzr'],
      :methods => ['has_many_polymorphs', 'acts_as_double_polymorphic_join'],
      :requirements => []}
    
    mattr_accessor :options
    @@options = HashWithIndifferentAccess.new(DEFAULT_OPTIONS)      

    # Dispatcher callback to load polymorphic relationships from the top down.
    def self.autoload

      _logger_debug "autoload hook invoked"
      
      options[:requirements].each do |requirement|
        require requirement
      end
    
      Dir[options[:file_pattern]].each do |filename|
        next if filename =~ /#{options[:file_exclusions].join("|")}/
        open filename do |file|
          if file.grep(/#{options[:methods].join("|")}/).any?
            begin
              model = File.basename(filename)[0..-4].camelize
              _logger_warn "preloading parent model #{model}"
              model.constantize
            rescue Object => e
              _logger_warn "WARNING; possibly critical error preloading #{model}: #{e.inspect}"
            end
          end
        end
      end
    end  
    
  end
    
end

Dispatcher.to_prepare do
  HasManyPolymorphs::Autoload.autoload
end
