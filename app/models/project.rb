class Project < ActiveRecord::Base
  has_attached_file :image,
                    styles: { standard: "200x200#" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

  validates :title, length: { minimum: 5, maximum: 150}, presence: true
  validates :category, presence: true
  validates :image, presence: true
end
