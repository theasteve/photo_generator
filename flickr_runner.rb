require 'flickraw'
require_relative './flickr_config'
require_relative './flickr_tool'

flickr_tool = FlickerPhotosTool.new(flickr)

photos = flickr_tool.get_photos( min_upload_date: '2017-01',
                                 max_upload_date: '2018-02',
                                 tags: "#dctech",
                                 extras: "count_comments,tags, url_m")
ranked_photos = flickr_tool.rank_photos(photos)

flickr_tool.display_photos(ranked_photos)
