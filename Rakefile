
require 'echoe'
require 'load_multi_rails_rake_tasks'

Echoe.new("has_many_polymorphs") do |p|  
  p.project = "fauna"
  p.summary = "An ActiveRecord plugin for self-referential and double-sided polymorphic associations."
  p.url = "http://blog.evanweaver.com/files/doc/fauna/has_many_polymorphs/"  
  p.docs_host = "blog.evanweaver.com:~/www/bax/public/files/doc/"  
  p.dependencies = ["activerecord"]
  p.rdoc_pattern = /polymorphs\/association|polymorphs\/class_methods|polymorphs\/reflection|polymorphs\/autoload|polymorphs\/configuration|README|CHANGELOG|TODO|LICENSE|templates\/migration\.rb|templates\/tag\.rb|templates\/tagging\.rb|templates\/tagging_extensions\.rb/    
  p.require_signed = true
  p.test_pattern = ["test/integration/*.rb", "test/unit/*.rb"]
end

desc "Run all the tests in production and development mode both"
task "test_all" do
  STDERR.puts "#{'='*80}\nDevelopment mode\n#{'='*80}"
  system("rake test:multi_rails:all")

  ENV['PRODUCTION'] = '1'
  STDERR.puts "#{'='*80}\nProduction mode\n#{'='*80}"
  system("rake test:multi_rails:all")
end
