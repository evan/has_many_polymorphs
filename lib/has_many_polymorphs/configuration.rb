
=begin rdoc
Access <tt>has_many_polymorphs_options</tt> in your Rails::Initializer.run#after_initialize block if you need to modify the behavior of HasManyPolymorphsAutoload.
=end

class Rails::Configuration

  def has_many_polymorphs_options
    Rails::Initializer::HasManyPolymorphsAutoload.options
  end
  
  def has_many_polymorphs_options=(hash)
    Rails::Initializer::HasManyPolymorphsAutoload.options = hash
  end
  
end

