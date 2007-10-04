
# Setup integration system for the integration suite

Dir.chdir "#{File.dirname(__FILE__)}/integration/app/" do
  %w(production development test).each do |env|
    ENV['RAILS_ENV'] = env
    system("rake db:create db:migrate db:fixtures:load")
  end
end
