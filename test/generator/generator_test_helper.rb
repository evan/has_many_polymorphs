
require 'fileutils'

require File.dirname(__FILE__) + '/../test_helper'

require 'tasks/rails'

class Test::Unit::TestCase  

  def in_rails
    Dir.chdir RAILS_ROOT { yield }
  end

  def setup_test_environment    
    in_rails do
      ENV['SCHEMA'] = RAILS_ROOT + "/db/schema.rb"
      
      system("rake db:drop")
      system("rake db:create")
      ["db/migrate", "app/models", "test/fixtures", "test/unit", "integration/app/lib/*_extensions.rb"].each do |dir|
        FileUtils.rm_rf dir
      end
      # Revert environment lib requires
      FileUtils.cp "config/environment.rb.canonical", "config/environment.rb"
    end
  end
  
  def migrate
    in_rails { system("rake db:migrate") }
  end
  
  def generate_model(name)
    in_rails { system("script/generate model #{name} name:string -q -f") }
  end
    
  def generate(*args)
    in_rails { system("script/generate #{args.join(" ")} -q -f") }
  end
  
  def run_unit_tests
    in_rails { system("rake test:units") }
  end
  
end