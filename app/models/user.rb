class User < ActiveRecord::Base
  def to_pleasant_string
    "username: #{name}    email: #{email}     password: #{password}  "
  end
end
