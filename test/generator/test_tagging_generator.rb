require File.dirname(__FILE__) + '/generator_test_helper'
require 'rails_generator'
require 'rails_generator/scripts/generate'

class TaggingGeneratorTest < Test::Unit::TestCase
  
  def setup
    setup_test_environment
    
    # Generate two models for our tags
    generate_model("Rock")
    generate_model("Pop")
    
    # Run tagging generator
    generate("tagging", "Rock", "Pop")
    
    # Delete existing migrations and migrate again
    migrate
  end
  
  def test_tags
    run_unit_tests
  end
end
