
require 'fileutils'

require File.dirname(__FILE__) + '/../test_helper'

require 'tasks/rails'

class Test::Unit::TestCase  
  def setup_test_environment
    Dir.chdir RAILS_ROOT do
      ENV['SCHEMA'] = RAILS_ROOT + "/db/schema.rb"
      
      system("rake db:drop")
      system("rake db:create")
      ["db/migrate", "app/models", "test/fixtures", "test/unit"].each do |dir|
        FileUtils.rm_rf dir
      end
      # Revert environment lib requires
      FileUtils.cp "config/environment.rb.canonical", "config/environment.rb"
    end
  end
  
  def migrate
    system("rake db:migrate")
  end
  
  def generate_model(name)
    Object.send(:remove_const, name) if Object.const_defined?(name)
    @generated_models ||= []
    Rails::Generator::Scripts::Generate.new.run(["model", name, "name:string", "-q", "-f"])
    load "#{name.downcase}.rb"
    @generated_models << name
  end
  
  def generate_dummy_records
    @generated_models.each do |name|
      load "#{name.downcase}.rb"
      2.times { name.constantize.create(:name => "foo#{rand(100)}") }
    end
  end
  
  def generate(*args)
    Rails::Generator::Scripts::Generate.new.run(args)
  end
  
  def run_unit_tests
    system("rake test:units")
  end
  
end