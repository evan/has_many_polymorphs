
require 'fileutils'

require File.dirname(__FILE__) + '/../test_helper'

require 'tasks/rails'

class Test::Unit::TestCase  
  def setup_test_environment
    @dir = Dir.pwd
    Dir.chdir RAILS_ROOT

    ENV['SCHEMA'] = RAILS_ROOT + "/db/schema.rb"
    
    system("rake db:drop")
    system("rake db:create")
    ["db/migrate", "app/models", "test/fixtures", "test/unit", "integration/app/lib/*_extensions.rb"].each do |dir|
      FileUtils.rm_rf dir
    end
    # Revert environment lib requires
    FileUtils.cp "config/environment.rb.canonical", "config/environment.rb"
  end
  
  def migrate
    system("rake db:migrate")
  end
  
  def generate_model(name)
    @generated_models ||= []
    system("script/generate model #{name} name:string -q -f")
    load "#{name.downcase}.rb"
    @generated_models << name
  end
    
  def run_unit_tests
    system("rake test:units")
  end
  
  def teardown
    Dir.chdir @dir
  end
  
end