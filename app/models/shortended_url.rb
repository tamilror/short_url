class ShortendedUrl < ApplicationRecord

  #set length of shor url
  UNIQUE_ID_LENGTH = 6
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url,
  with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create :generate_short_url

  # Generate a uniq url for given web address
  def generate_short_url
    url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
    old_url = ShortendedUrl.where(short_url: url).last
    if old_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end

  # check if any url exists or not
  def find_duplicate
    ShortendedUrl.find_by_original_url(self.original_url)
  end

  def new_url?
    find_duplicate.nil?
  end

end
