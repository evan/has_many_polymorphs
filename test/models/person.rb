require 'parentship'
class Person < ActiveRecord::Base                   
  has_many_polymorphs :kids,
                      :through => :parentships, 
                      :from => [:people], 
                      :as => :parent,
                      :conditions => "people.age < 10"   
end                                               
