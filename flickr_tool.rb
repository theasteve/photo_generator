class FlickerPhotosTool
  attr_reader :photos, :flickr

  def initialize(flickr_item)
    @flickr = flickr_item
  end

  def get_photos(args={})
    @photos = @flickr.photos.search(args)
  end

  def rank_photos(photos)
    @photos.sort_by { |photo| photo.count_comments.to_i * -1 }
  end

  def display_photos(photos)
    photos.each {|photo| puts photo.url_m }
  end
end
