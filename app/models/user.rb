# == Schema Information
# Schema version: 20110119160607
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password #Create a virtual password for checking password confirmation, only encrypted password will be stored in the database
  attr_accessible :name, :email, :password, :password_confirmation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length => {:maximum => 20}

  validates :email, :format => {:with=>email_regex},
                    :uniqueness => {:case_sensitive =>false}

  validates :password, :presence => true,
                       #:length => {:minimum => 6, :maximum => 50},
                       :length => {:within => 6..50},
                       :confirmation => true

  before_save :encrypt_password

  def has_password?(submitted_password)
    self.encrypted_password == submitted_password
  end
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt (string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash (string)
      Digest::SHA2.hexdigest(string)
    end
end
