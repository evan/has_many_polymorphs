require File.dirname(__FILE__) + '/generator_test_helper'

class TaggingGeneratorTest < Test::Unit::TestCase
  
  def setup
    setup_test_environment
    
    # Generate two models for our tags
    generate_model("Stick")
    generate_model("Stone")
    
    # Run tagging generator
    generate("tagging", "Stick", "Stone")
    
    # Delete existing migrations and migrate again
    migrate
  end
  
  def test_tags
    run_unit_tests
  end
end
