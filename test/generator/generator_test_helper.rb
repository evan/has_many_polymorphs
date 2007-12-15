require File.dirname(__FILE__) + '/../test_helper'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

class Test::Unit::TestCase  
  def setup_test_environment
    chdir(RAILS_ROOT)
    ENV['SCHEMA'] = RAILS_ROOT + "/db/schema.rb"
    
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    ["db/migrate", "app/models", "test/fixtures", "test/unit"].each do |dir|
      command = "rm -rf #{RAILS_ROOT}/#{dir}/*"
      system command
    end
  end
  
  def migrate
    Rake::Task["db:migrate"].invoke
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
    Rake::Task["test:units"].invoke
  end
  
end