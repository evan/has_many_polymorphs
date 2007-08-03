
require 'rubygems'
require 'echoe'

Echoe.new("has_many_polymorphs", `cat CHANGELOG`[/^v([\d\.]+)\. /, 1]) do |p|
  
  p.name = "has_many_polymorphs"
  p.rubyforge_name = "fauna"
  p.description = p.summary = "Ruby on Rails plugin for defining self-referential polymorphic associations."
  p.url = "http://blog.evanweaver.com/pages/code#polymorphs"
  p.changes = `cat CHANGELOG`[/^v([\d\.]+\. .*)/, 1]
  
  p.docs_host = "blog.evanweaver.com:~/www/snax/public/files/doc/"
  p.need_tar = false
  p.need_tar_gz = true  
  
  p.rdoc_pattern = /lib|generators|\.\/README|CHANGELOG|LICENSE|TAGGING_INSTALL|install|init/
    
end
