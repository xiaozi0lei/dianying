class User < ActiveRecord::Base
  acts_as_messageable
  before_save { if email; email.downcase! ; end }
  attr_accessible :email, :name, :password, :password_confirmation, :provider, :uid

  attr_accessor :password
  before_save :encrypt_password

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # 判断是否为Oauth2登陆
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :password, :on => :create, :if => :password_required?
  validates :password, length: { minimum: 6 }, :if => :password_required?
  validates_uniqueness_of :email, :if => :password_required?
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

  def self.create_from_omniauth(auth_hash)
    self.create(provider: auth_hash[:provider],
              uid: auth_hash[:uid],
              name: auth_hash[:info][:name])
  end

  def password_required?
    provider.blank?
  end

end
