
# Setup integration system for the integration suite

Dir.chdir "#{File.dirname(__FILE__)}/integration/app/" do
  ENV['RAILS_ENV'] = 'development'
  system("rake db:create db:migrate db:fixtures:load")
  ENV['RAILS_ENV'] = 'test'
  system("rake db:create db:migrate db:fixtures:load")
end
