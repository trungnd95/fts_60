class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  enum role: [:admin, :user]
  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy

  mount_uploader :avatar, PictureUploader
  validate  :picture_size

  scope :normal_user, ->{where role: Settings.role_user}

  before_create :normal_user_role

  private
  def picture_size
    if avatar.size > 8.megabytes
      errors.add :avatar, t("views.devise.models.user")
    end
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end

  def normal_user_role
    self.role =  Settings.role_user
  end
end
