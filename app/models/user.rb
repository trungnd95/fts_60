class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :user]

  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy

  mount_uploader :avatar, PictureUploader
  validate  :picture_size

  private
  def picture_size
    if avatar.size > 8.megabytes
      errors.add :avatar, t("views.devise.models.user")
    end
  end
end
