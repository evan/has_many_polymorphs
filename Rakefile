
require 'echoe'

Echoe.new("has_many_polymorphs") do |p|  
  p.project = "fauna"
  p.summary = "An ActiveRecord plugin for self-referential and double-sided polymorphic associations."
  p.url = "http://blog.evanweaver.com/files/doc/fauna/has_many_polymorphs/"  
  p.docs_host = "blog.evanweaver.com:~/www/bax/public/files/doc/"  
  p.dependencies = ["activerecord"]
  p.rdoc_pattern = /polymorphs\/association|polymorphs\/class_methods|polymorphs\/reflection|polymorphs\/autoload|polymorphs\/configuration|README|CHANGELOG|TODO|LICENSE|templates\/migration\.rb|templates\/tag\.rb|templates\/tagging\.rb|templates\/tagging_extensions\.rb/    
  p.require_signed = true
  p.test_pattern = ["test/unit/test_*.rb", "test/integration/test_*.rb", "test/generator/test_*.rb"]
end

desc "Run all the tests for every database adapter" 
task "test_all" do
  ['postgresql', 'sqlite3'].each do |adapter|
    ENV['DB'] = adapter
    ENV['PRODUCTION'] = nil
    STDERR.puts "#{'='*80}\nDevelopment mode for #{adapter}\n#{'='*80}"
    system("rake test:multi_rails:all")
  
    # XXX Right now we don't test anything that depends on this, although we should
    #
    # ENV['PRODUCTION'] = '1'
    # STDERR.puts "#{'='*80}\nProduction mode for #{adapter}\n#{'='*80}"
    # system("rake test:multi_rails:all")
    
  end
end

namespace :test do
  Rake::TestTask.new(:generator) do |t|
    t.libs << "test"
    t.pattern = 'test/generator/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:generator'].comment = "Run generator tests in real application"
end
