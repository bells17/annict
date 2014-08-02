class Profile < ActiveRecord::Base
  dragonfly_accessor :avatar do
    default 'public/images/no_image.png'
  end
  dragonfly_accessor :background_image

  belongs_to :user

  validates :description, length: { maximum: 150 }
  validates :name, presence: true

  before_validation :rename_file


  private

  def rename_file
    avatar.name = random_file_name(avatar) if avatar.present?
    background_image.name = random_file_name(background_image) if background_image.present?
  end

  def random_file_name(file)
    ext = file.name.scan(/\.[a-zA-Z]+$/).first.presence || ''
    SecureRandom.hex(16) + ext
  end
end