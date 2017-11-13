class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  # before_create :skip_confirmation!

  EMAIL_REGEXP = Devise.email_regexp
  PASSWORD_MIN_LENGTH = 6

  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: PASSWORD_MIN_LENGTH },
            allow_nil: true

  def set_default_role
    self.role ||= :user
  end

  def admin?
    role == 'admin'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end