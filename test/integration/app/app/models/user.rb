class User < ActiveRecord::Base
  has_one   :seller
  has_one   :address

  is_indexed :fields => ['login', 'email']
end
