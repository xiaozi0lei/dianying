class User < ActiveRecord::Base
  acts_as_messageable
  before_save { email.downcase! }
  attr_accessible :email, :name, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :password, length: { minimum: 6 }
  validates_uniqueness_of :email
  validates_uniqueness_of :name

  has_many :articles, dependent: :destroy

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # Used by mailboxer for notification
  # Returns the name of the user
  def mailboxer_name
    return "#{name}"
  end

end
