
$VERBOSE = nil
require 'rubygems'
require 'echoe'
require 'test/unit'
require 'multi_rails_init'
require 'ruby-debug'

HERE = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << HERE

require 'integration/app/config/environment'
require 'test_help'

Inflector.inflections {|i| i.irregular 'fish', 'fish' }

$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path = HERE + "/fixtures")
$LOAD_PATH.unshift(HERE + "/models")
$LOAD_PATH.unshift(HERE + "/modules")

class Test::Unit::TestCase
  self.use_transactional_fixtures = !(ActiveRecord::Base.connection.is_a? ActiveRecord::ConnectionAdapters::MysqlAdapter rescue false)
  self.use_instantiated_fixtures  = false
end

Echoe.silence do
  load(HERE + "/schema.rb")
end
