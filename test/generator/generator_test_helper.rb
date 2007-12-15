
require 'fileutils'
require File.dirname(__FILE__) + '/../test_helper'

class Test::Unit::TestCase  

  def in_rails
    Dir.chdir(RAILS_ROOT) { yield }
  end

  def setup_test_environment    
    in_rails do
      ["log", "generated_models", "db/schema.rb", "db/migrate", "app/models", "test/fixtures", "test/unit", "lib/*_extensions.rb"].each do |dir|
        FileUtils.rm_rf dir
      end
      system("mkdir log; touch log/development.log")
      system("rake db:drop")
      system("rake db:create")
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