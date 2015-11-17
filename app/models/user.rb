class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :favoris
  has_many :messages
  has_many :appointments
  validates :first_name, presence: true
  validates :last_name, presence: true

  validate :valid_rpps
  validates_numericality_of :rpps
  validates :rpps, length: { is: 11 }

  validates :pseudo, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:facebook]



  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def valid_rpps
    if not is_valid_rpps(rpps)
      errors.add(:rpps, "is not a valid rpps number")
    end
  end

  private

  def is_valid_rpps(code)
    s1 = s2 = 0
    code.to_s.reverse.chars.each_slice(2) do |odd, even|
      s1 += odd.to_i

      double = even.to_i * 2
      double -= 9 if double >= 10
      s2 += double
    end
    (s1 + s2) % 10 == 0
  end

  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end

end
