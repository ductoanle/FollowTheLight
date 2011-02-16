class Image < ActiveRecord::Base
  validates_presence_of :name, :url, :format
  validates_uniqueness_of :url
  validates_inclusion_of :format, :in => ["JPG","PNG","GIF","TIF"]
end
